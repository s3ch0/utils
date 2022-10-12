from PIL import Image
import math


def gainCnum(enum: int) -> int:
    while (True):
        if (int(math.sqrt(enum)) * int(math.sqrt(enum)) == enum):
            return enum
        else:
            enum += 1


def parse_data():
    pass


def insertdata():
    pass


#  image = Image.new()
if __name__ == '__main__':

    with open('./flag.zip', 'rb') as container:
        raw_data = bytearray(container.read())
    cnum = gainCnum(len(raw_data))
    diff_len = cnum - len(raw_data)
    raw_data.extend(bytes(diff_len))
    wh = int(math.sqrt(cnum))
    im = Image.new("RGB", (wh, wh))
    data_list = [raw_data[i:i + wh] for i in range(0, cnum, wh)]
    assert (len(data_list[-1]) == wh)
    print(len(data_list))
    print(len(data_list[-1]))
    for heigh in range(wh):
        for width in range(wh):
            im.putpixel((heigh, width), (255, 255, data_list[heigh][width]))
    im.save("flag.png")
