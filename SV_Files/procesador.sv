
`timescale 1 ps / 1 ps
module procesador(
	input logic clk,
	input logic [31:0] address_IO, 
	output logic [7:0] q_IO
);
	logic [0:24] flags;
	//										//								//
								// Instrucction fetch
	logic [31:0] pc_branch;
	logic [31:0] pc_jump;
	logic [31:0] pc_4;
	logic [1:0] sel_pc;	//Control
	assign sel_pc = flags[0:1];
	
	logic [31:0] pc_slct;
	
	logic [31:0] pc_dir;
	
	fulladder pc_mas4(pc_dir, 1, 0, pc_4);
	
	mux_4x1 mux_IF (pc_4, pc_jump, pc_branch, 0,sel_pc, pc_slct);
	
	logic pc_on;		// Control
	assign pc_on = flags[2];
	regPC pc_reg (clk, pc_on, pc_slct, pc_dir);
	
	
	//									//									// 
									// IF/ID
	logic wr_allow_IF_ID;	//  Control
	assign wr_allow_IF_ID = flags[17];
	
	logic [1:0] nme_ID; 
	logic [3:0] Rd_ID, Rs1_ID, Rs2_ID;
	logic [2:0] opcode_ID;
	
	logic [18:0] imm_2R1_ID; 
	logic [22:0] imm_RI_ID; 
	logic [26:0] imm_J_ID;
	
	logic [31:0] inst;
	
	logic flush;
	assign flush = flags[23];
	
	regs_IF_ID reg_IF_ID(clk, wr_allow_IF_ID, flush, inst, 
						 nme_ID, 
						 Rd_ID, Rs1_ID, Rs2_ID,
						 opcode_ID,
						 imm_2R1_ID, 
						 imm_RI_ID, 
						 imm_J_ID);
						 
						 
	// 								//									// 
								//Instruction Decoder	
	branch_jump_pc bj_extnd (imm_J_ID, imm_2R1_ID, pc_jump, pc_branch);
	
	logic slct_rs1;	//Control
	assign slct_rs1 = flags[4];
	logic [3:0] out_Rs1_ID;
	mux_2x1 mux1(Rs1_ID, Rd_ID, slct_rs1, out_Rs1_ID);
	
	logic slct_rs2;		//Control
	assign slct_rs2 = flags[5];
	logic [3:0] out_Rs2_ID;
	mux_2x1 mux2(Rs2_ID, Rs1_ID, slct_rs2, out_Rs2_ID);
	
	logic reg_rd;		//Control
	logic reg_wr;		//Registro WR
	assign reg_rd = flags[6];
	logic [3:0] final_Rd_WB;
	logic [31:0] final_result_WB;
	logic [31:0] D1_out_ID, D2_out_ID;
	logic [31:0] D1_out, D2_out;
	
	memReg registers (reg_rd, reg_wr, clk,
							final_Rd_WB,out_Rs1_ID,out_Rs2_ID,
							final_result_WB,
							D1_out, D2_out);
	
	// Señales para unidad de adelanteamiento 
	logic ID1_adel, ID2_adel, EXE1_adel, EXE2_adel;
	logic [31:0] ID_D1, ID_D2, EXE_D1, EXE_D2;
	mux_2x1 mux4(D1_out, ID_D1, ID1_adel, D1_out_ID);
	mux_2x1 mux5(D2_out, ID_D2, ID2_adel, D2_out_ID);
	
	
	logic [1:0] imm_ctrl; 		//Control
	assign imm_ctrl = flags[8:9];
	logic [31:0] imm_ext_out;
	ext_module imm_ext(imm_2R1_ID, imm_RI_ID, imm_ctrl, imm_ext_out);
	
	logic br_ctrl;				//Control
	assign br_ctrl = flags[10];
	logic branch_slct;
	branch_detector brch_d (D1_out_ID, D2_out_ID, br_ctrl, branch_slct);
	 
	
	//									//								// 
									//ID_EX
	logic wr_allow_ID_EX;			// Control
	assign wr_allow_ID_EX = flags[18];
	
	logic [3:0]  unit_in; 			//Control
	assign unit_in = flags[19:22];
	
	
	logic [3:0] out_Rd_Ex, out_Rs1_Ex, out_Rs2_Ex, unit_out_Ex, div_Rd_Ex; 
	logic [31:0] out_D1_Ex, out_D2_Ex; 
	logic [31:0] out_imm_Ex;
	logic [0:5] flags_EXE;
	
	
	regs_ID_EXE reg_ID_EX(clk, wr_allow_ID_EX, flags[11:16],
						  Rd_ID, out_Rs1_ID, out_Rs2_ID, unit_in,
						  D1_out_ID, D2_out_ID, 
						  imm_ext_out, 
						  out_Rd_Ex, out_Rs1_Ex, out_Rs2_Ex, unit_out_Ex, 
						  out_D1_Ex, out_D2_Ex, 
						  out_imm_Ex, div_Rd_Ex, 
						  flags_EXE);
						  
	//									//								// 
									//Execute
	
	logic [31:0] D1_EXE;
	logic [31:0] D2_EXE;
	mux_2x1 mux6(out_D1_Ex, EXE_D1, EXE1_adel, D1_EXE);
	mux_2x1 mux7(out_D2_Ex, EXE_D2, EXE2_adel, D2_EXE);
	
	
	
	logic sela_alu; 		//Control
	assign sela_alu = flags_EXE[0]; 
	logic [31:0] A;
	mux_2x1 mux3(D1_EXE, 32'b0, sela_alu, A);
	
	logic [1:0] alu_funct;	// Control de ALU
	logic [31:0] alu_out_Ex;
	ALU alu_module(A, out_imm_Ex, alu_funct, alu_out_Ex);
	
	logic [31:0] mul_out_Ex;
	mul mul_module (clk, D1_EXE, D2_EXE, mul_out_Ex);
	
	logic mod_ena;			//Control
	assign mod_ena = flags_EXE[1];
	logic [31:0] out_div_Ex;
	logic div_state;
	logic write_Ex_WB;
	
	mod_operation modulus_op(clk, flags[24],mod_ena, D1_EXE, D2_EXE, out_div_Ex, div_state, write_Ex_WB);
	 
	logic wr_ena;	//Control
	logic selb_admem; // Control
	assign selb_admem = wr_ena;
	logic [31:0] a_admem;
	mux_2x1 mux9 (D2_EXE, D1_EXE, selb_admem, a_admem);
	logic [31:0] b_admem;
	mux_2x1 mux8 (out_imm_Ex, D2_EXE, selb_admem, b_admem);
	 
	logic [31:0] address_m_Ex;
	fulladder sum_mem(a_admem, b_admem,0, address_m_Ex); 
	 
	
	// Instance memory //
	logic rd_allow; // Control de ID
	logic d_ena; 	//Control 
	assign rd_allow = flags[3];	//Flags de la ID
	assign d_ena = (flags_EXE[4] | flags_EXE[5]);
	assign wr_ena = (!flags_EXE[5] & flags_EXE[4]); 
	logic [31:0] q_D_Ex;
	
	logic [31-1:0] q_VGA;
	assign q_IO = q_VGA[7:0];
	
	central_memory mem(clk, pc_dir, rd_allow, 
						address_m_Ex, address_m_Ex, address_IO, flags_EXE[4], flags_EXE[5],
						D1_EXE, inst, q_D_Ex, q_VGA);
						
	//								//						//	
								//EX/WB
	logic [3:0] out_alu_Rd_WB, out_ld_Rd_WB, out_mul_Rd_WB, out_div_Rd_WB;
	logic [31:0] alu_wb, ld_wb, mul_wb, div_wb;
	
	logic storage;		//Entrada control
	logic [3:0] wr_allow_WB;	//Control
	logic [3:0] temp_write;
	assign temp_write = {4{flags[7]}};
	logic [3:0] temp_WB;
	assign temp_WB = {unit_out_Ex[3:1], write_Ex_WB};
	assign wr_allow_WB = temp_write & temp_WB;
	
	regs_EXE_WB reg_Ex_WB(clk, wr_allow_WB, 
								out_Rd_Ex, out_Rd_Ex, out_Rd_Ex, div_Rd_Ex, 
								alu_out_Ex, q_D_Ex, mul_out_Ex, out_div_Ex, 
								final_Rd_WB,
								out_alu_Rd_WB, out_ld_Rd_WB, out_mul_Rd_WB, out_div_Rd_WB,
								final_result_WB,
								alu_wb, ld_wb, mul_wb, div_wb, storage, reg_wr);
			
			
	  
	//								//								//
	unidadAdelantamiento unidad_ade (out_alu_Rd_WB, out_ld_Rd_WB, out_mul_Rd_WB, out_div_Rd_WB,
								out_Rs1_ID, out_Rs2_ID, out_Rs1_Ex, out_Rs2_Ex,
								alu_wb, ld_wb, mul_wb, div_wb,
								ID1_adel, ID2_adel, EXE1_adel, EXE2_adel,
								ID_D1, ID_D2, EXE_D1, EXE_D2);
							
		
	//Control alu
	logic[1:0] code;
	assign code = flags_EXE[2:3];
	alu_control alu_ctr(code, alu_funct);
	
	//Riesgos de RAW por division
	logic risk_r;
	div_risk div_risk1 (out_Rs1_ID, out_Rs2_ID, div_Rd_Ex, risk_r);
	
	// Unidad de control
	logic [4:0] code_funct; 	//Formar con opcode y nme IF/ID
	assign code_funct = {nme_ID, opcode_ID};
	control_unit ctr_unit_module(code_funct, branch_slct, div_state, risk_r, storage, flags);
	

endmodule
