def bin_to_mif(bin_data):
    depth = len(bin_data)
    width = len(bin_data[0])

    lenght = len(hex(depth).replace("0x", ""))
    buffer = "DEPTH = " + str(depth) + ";\nWIDTH = " + str(width) + \
        ";\nADDRESS_RADIX = HEX;\nDATA_RADIX = BIN;\nCONTENT\nBEGIN\n"

    for i in range(len(bin_data)):
        line = hex(i).replace("0x", "")
        buffer += "0" * (lenght - len(line)) + line + \
            " : " + bin_data[i].strip() + ";\n"

    buffer += "END;"

    return buffer

# Buffer es una lista con el binario correspondiente de la palabra que se va a guardar
# Ejemplo: ["101010", "011101"]


def write_file(buffer, name):

    buffer = bin_to_mif(buffer)

    code = open(name+".mif", "w")
    code.write(buffer)
    code.close
