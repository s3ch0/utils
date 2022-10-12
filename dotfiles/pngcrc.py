#coding=utf-8
import sys
import zlib
import struct

assert (len(sys.argv) == 2)
file = sys.argv[1]
fr = open(file, 'rb').read()
data = bytearray(fr[12:29])
# there hava a bug
hex_crc32key = ""
for i in fr[29:33]:
    hex_crc32key += str(hex(i))[2:]

ord_crc32key = int(hex_crc32key, 16)

n = 4095 #理论上0xffffffff,但考虑到屏幕实际，0x0fff就差不多了
for w in range(n): #高和宽一起爆破
    width = bytearray(struct.pack('>i', w)) #q为8字节，i为4字节，h为2字节
    for h in range(n):
        height = bytearray(struct.pack('>i', h))
        for x in range(4):
            data[x + 4] = width[x]
            data[x + 8] = height[x]
            #print(data)
        crc32result = zlib.crc32(data)
        if crc32result == ord_crc32key:
            print(width, height)
            #写文件
            newpic = bytearray(fr)
            for x in range(4):
                newpic[x + 16] = width[x]
                newpic[x + 20] = height[x]
            fw = open(file + '.png', 'wb') #保存副本
            fw.write(newpic)
            fw.close

if __name__ == '__main__':
    pass
