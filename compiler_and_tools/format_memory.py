import bin_to_mif

# Toma una imagen txt y lo pasa a .mif de 16 o 32 bits por palabra
# If word_flag = True -> Output file.mif will contains 32 bits words
# If word_flag = False -> Output file.mif will contains 16 bits wordsz


def format_memory(number_of_files, word_flag, file_name, output_name):
    file_name = open(file_name, "r")

    lista = []
    for line in file_name:
        if(line[0] != '#'):
            for a in line.split(' '):
                if(a != '\n' and a != ''):
                    lista.append(a)
    i = 0

    buffer = []
    if not word_flag:
        while i < len(lista):
            buffer.append(dec_to_bin_word(word_flag, lista[i], lista[i+1]))
            i += 2
    else:
        while i < len(lista):
            buffer.append(dec_to_bin_word(
                word_flag, lista[i], lista[i+1], lista[i + 2], lista[i + 3]))
            i += 4

    chunks = len(buffer) // 65536

    if len(buffer) % 65536 != 0:
        chunks += 1
    if chunks <= 1:
        bin_to_mif.write_file(buffer, output_name)
    else:
        i = 0
        while i < chunks:
            if (i+1) * 65536 >= len(buffer):
                bin_to_mif.write_file(buffer[i*65536:-1], output_name + str(i))
            else:
                bin_to_mif.write_file(
                    buffer[i*65536:(i+1)*65536], output_name + str(i))
            i += 1
    while chunks < number_of_files:
        bin_to_mif.write_file(["0"*len(buffer[0])], output_name + str(chunks))
        chunks += 1

    file_name.close()




def dec_to_bin_word(word_flag, first_byte, second_byte, third_byte="", fourth_byte=""):

    first_byte = int(first_byte.strip())
    second_byte = int(second_byte.strip())

    first_byte = bin(first_byte).replace("0b", "")
    second_byte = bin(second_byte).replace("0b", "")

    first_byte = ("0" * (8 - len(first_byte))) + first_byte
    second_byte = ("0" * (8 - len(second_byte))) + second_byte

    if word_flag:
        third_byte = int(third_byte.strip())
        fourth_byte = int(fourth_byte.strip())

        third_byte = bin(third_byte).replace("0b", "")
        fourth_byte = bin(fourth_byte).replace("0b", "")

        third_byte = ("0" * (8 - len(third_byte))) + third_byte
        fourth_byte = ("0" * (8 - len(fourth_byte))) + fourth_byte

        return first_byte + second_byte + third_byte + fourth_byte

    return first_byte + second_byte


format_memory(3, False, "7.txt", "img_memory_16")
