from string import ascii_letters

# the Default start pixel
START_PIX_X = 10 # (X axis)
START_PIX_Y = 10 # (Y axis)


# function to parse the usr's input strings
def parse_str(usr_input: str) -> str:
    if usr_input not in ascii_letters:
        print("You must input printable ascii")
    for i in usr_input:
        pass
    return 'a'


# this function will save the postscript code to a specific file
def save():
    pass


if __name__ == '__main__':
    pass
