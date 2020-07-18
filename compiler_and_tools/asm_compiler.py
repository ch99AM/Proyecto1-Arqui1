import bin_to_mif
import os.path

CODE_BUFFER = []  # Global variable to save each instruction

PARSE_CODE = []  # Global Variable to save the code compiled

# Valid operations
OPERATIONS = {
    "lb": {
        "op": "00",
        "func": "000"
    },
    "mod": {
        "op": "00",
        "func": "001"
    },
    "mul": {
        "op": "00",
        "func": "010"
    },
    "sumi": {
        "op": "01",
        "func": "000"
    },
    "andi": {
        "op": "01",
        "func": "001"
    },
    "be": {
        "op": "01",
        "func": "010"
    },
    "bne": {
        "op": "01",
        "func": "011"
    },
    "mov": {
        "op": "01",
        "func": "100"
    },
    "sw": {
        "op": "01",
        "func": "101"
    },
    "srd": {
        "op": "01",
        "func": "110"
    },
    "li": {
        "op": "10",
        "func": "000"
    },
    "j": {
        "op": "11",
        "func": "000"
    },
    "end": {
        "op": "11",
        "func": "111"
    }
}

# Registers to the compiler
REGISTERS = {
    "c0": "0000",
    "c1": "0001",
    "c2": "0010",
    "c3": "0011",
    "c4": "0100",
    "c5": "0101",
    "r0": "0110",
    "r1": "0111",
    "r2": "1000",
    "r3": "1001",
    "r4": "1010",
    "r5": "1011",
    "r6": "1100",
    "r7": "1101",
    "r8": "1110",
    "r9": "1111"
}

BRANCHES = {}  # Global variable with the labels and they memory address


# Extract each line in the txt file
def read_file(code):
    global CODE_BUFFER
    code = open(code, "r").read().strip().split("\n")
    fail = False
    for i in range(len(code)):
        line = code[i]
        if len(line) == 0:
            code.remove(code[i])
            continue
        index = line.find(";")
        if index == -1:
            fail = True
            print("Syntax error in line %d, there is no ';'" % (i+1))
            exit()
            break
        line = line[0:index].replace("\t", " ").strip().split(" ")

        j = 0
        while j < len(line):
            if len(line[j]) == 0:
                del line[j]
                j = 0
                continue
            j += 1

        for j in range(len(line)):
            if "," in line[j]:
                line[j] = line[j].replace(",", "")
        code[i] = line
        print(code[i])
    if not fail:
        CODE_BUFFER = code


# Search labels in the code to set valid memory address
def label_identifier():
    global BRANCHES, OPERATIONS
    for i in range(len(CODE_BUFFER)):
        line = CODE_BUFFER[i]

        if line[0] not in OPERATIONS:
            if ":" not in line[0]:
                print(
                    "Syntax error in line %d, there is not ':' after the label" % (i+1))
                exit()
                break
            else:
                BRANCHES.update({line[0][0:-1]: str(i*4)})
                del line[0]
                CODE_BUFFER[i] = line
        else:
            continue


# Set a valid imm according with the OP code
#   :: operator :: OP code (str)
#   :: number   :: Immediate binary (str)
def validate_imm(operator, number):

    number = decimal_to_bin(number)

    length = len(number)

    if operator == "01":
        if length > 19:
            print("Not supported number, too big")
            exit()

        number = ("0" * (19 - length)) + number
    elif operator == "10":
        if length > 23:
            print("Not supported number, too big")
            exit()

        number = ("0" * (23 - length)) + number
    else:
        if length > 27:
            print("Not supported number, too big")
            exit()
        number = ("0" * (27 - length)) + number

    return number


# main function to parse each code line
def parse_code():
    global CODE_BUFFER, OPERATIONS
    for i in range(len(CODE_BUFFER)):
        line = CODE_BUFFER[i]
        if line[0] not in OPERATIONS:
            print("Syntax error in line %d, %s is not a valid operation" %
                  (i+1, line[0]))
            exit()
        else:
            operation = OPERATIONS[line[0]]
            if operation["op"] == "00":
                three_reg_operation(operation, line)
            elif operation["op"] == "01":
                two_reg_imm_operation(operation, line)
            elif operation["op"] == "10":
                reg_imm_operation(operation, line)
            else:
                imm_operation(operation, line)


# Compile asm instruction to OPcode = 00 (Three Registers)
#     :: operation :: OP and Func (Hash)
#     :: line :: instruction to compile (list)
def three_reg_operation(operation, line):
    global PARSE_CODE
    for i in range(1, len(line)):
        if line[i] not in REGISTERS:
            print("Register %s not found" % line[i])
            exit()
    coded_line = operation["op"] + REGISTERS[line[1]] + REGISTERS[line[2]] + \
        REGISTERS[line[3]] + ("0" * 15) + operation["func"]
    PARSE_CODE.append(coded_line)


# Compile asm instruction to OPcode = 01 ( Two Registers and Imm)
#     :: operation :: OP and Func (Hash)
#     :: line :: instruction to compile (list)
def two_reg_imm_operation(operation, line):
    global PARSE_CODE
    if operation["func"] == "100":
        line.append("0"*19)
    for i in range(1, len(line)):
        if i == 3:
            if line[0] == "mov":
                continue
            else:
                if line[i] in BRANCHES:
                    line[i] = validate_imm(operation["op"], BRANCHES[line[i]])
                elif "#" not in line[i]:
                    print(
                        "Syntax error, there is no '#' before number, %s" % line[0]+line[1]+line[2]+line[3])
                    exit()
                elif len(line[i]) > 1 and line[i].replace("#", "").isnumeric():
                    line[i] = validate_imm(
                        operation["op"], line[i].replace("#", ""))
                else:
                    print(
                        "Syntax error, there is no number in %s" % line[0]+line[1]+line[2]+line[3])
                    exit()
        elif line[i] not in REGISTERS:
            print("Register %s not found" % line[i])
            exit()

    coded_line = operation["op"] + REGISTERS[line[1]] + \
        REGISTERS[line[2]] + line[3] + operation["func"]
    PARSE_CODE.append(coded_line)


# Compile asm instruction to OPcode = 10 (Register and Imm)
#     :: operation :: OP and Func (Hash)
#     :: line :: instruction to compile (list)
def reg_imm_operation(operation, line):
    global PARSE_CODE

    for i in range(1, len(line)):
        if i == 2:
            if "#" not in line[i]:
                print(
                    "Syntax error, there is no '#' before number, %s %s %s" % (line[0], line[1], line[2]))
                exit()
            elif len(line[i]) > 1 and line[i].replace("#", "").isnumeric():
                line[i] = validate_imm(
                    operation["op"], line[i].replace("#", ""))
            else:
                print(
                    "Syntax error, there is no number in %s %s %s" % (line[0], line[1], line[2]))
                exit()
        else:
            if line[i] not in REGISTERS:
                print("Register %s not found" % line[i])
                exit()

    coded_line = operation["op"] + REGISTERS[line[1]] + \
        line[2] + operation["func"]
    PARSE_CODE.append(coded_line)


# Compile asm instruction to OPcode = 11
#     :: operation :: OP and Func (Hash)
#     :: line :: instruction to compile (list)
def imm_operation(operation, line):
    global PARSE_CODE
    coded_line = ""
    if operation["func"] == "111":
        if len(line) > 1:
            print("Too much arguments, function end expected 0, get %d" %
                  (len(line) - 1))
        coded_line = operation["op"] + ("0" * 27) + operation["func"]
    elif line[1] not in BRANCHES:
        print("Error, not valid label in %s %s" % (line[0], line[1]))
        exit()
    else:
        coded_line = operation["op"] + validate_imm(
            operation["op"], BRANCHES[line[1]]) + operation["func"]

    PARSE_CODE.append(coded_line)


# Convert decimal number to binary number
#     :: num :: Decimal number to convert (str)
def decimal_to_bin(num):
    """

    """
    num = int(num)
    return bin(num).replace("0b", "")


# main function - Run this!
def main():
    print("___ Hello, ASM compiler ___ \n")
    answer = ""
    while answer != "exit" and answer != "e":
        answer = str(input("Please type: \n\
        compile / c -> To compile a file\n \
        exit / e -> To finish the compiler\n \
        >> ")).lower().strip()
        if answer == "c" or answer == "compile":
            answer_file = str(input("Please enter a file (.txt) with the asm code: \n\
            If don't want to compile a file, please type 'exit / e'\n \
            >> ")).lower().strip()
            if answer_file != "exit" and answer_file != "e":
                answer_output = str(input("Please enter the name of the output file: \n\
                If don't want to compile a file, please type 'exit / e'\n \
                >> ")).lower().strip()
                if answer_output != "exit" and answer_output != "e":
                    if os.path.exists(answer_file):
                        read_file(answer_file)
                        if len(CODE_BUFFER) == 0:
                            print("Please enter a valid code\n")
                            exit()
                        else:
                            label_identifier()
                            parse_code()
                            bin_to_mif.write_file(PARSE_CODE, answer_output)
                    else:
                        print("File not found in path, please enter a valid file\n")
    print("\nBye!")


main()
