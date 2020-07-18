from PIL import Image
from PIL import ImageTk, Image

mem1 = "./mem1.mem"
mem2 = "./mem2.mem"
mem3 = "./mem3.mem"

def main(width, height):

    size = width * height

    bytes_list = []
    bytes_list.append(converter(mem1))
    bytes_list.append(converter(mem2))
    bytes_list.append(converter(mem3))

    img = [item for sublist in bytes_list for item in sublist]

    print(len(img))
    del img[(size-1):(len(img)-1)]

    print(len(img))

    img = [int(x, 16) for x in img]

    image_out = Image.new(mode="L", size=(width, height))
    image_out.putdata(img)

    image_out.save('test_out.png')


def converter(mem):
    byte_list = []
    with open(mem, 'r') as file:
        file.read(1)
        file.readline()
        file.readline()
        file.readline()
        byte = file.read(6)
        while byte:
            if byte == '\n':
                byte = file.read(6)
            while byte != '\n' and byte:
                byte_list.append(file.read(2))
                byte = file.read(1)
        byte_list.pop(len(byte_list) - 1)
    return byte_list

main(320,320)
