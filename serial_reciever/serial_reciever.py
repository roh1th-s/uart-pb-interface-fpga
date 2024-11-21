import serial
import pyautogui

# Change COM port as required
ser = serial.Serial('COM27', 921600, timeout=0.1)  # 1/timeout is the frequency at which the port is read

while True:
    data = ser.readline()

    if data:
        # print as binary
        # binary_string = ''.join(format(byte, '08b') for byte in data)
        # print(binary_string)

        if (data == b'\x00'):
            pyautogui.press('enter')
            print("Center")
        elif (data == b'\x01'):
            pyautogui.press('up')
            print("Up")
        elif (data == b'\x02'):
            pyautogui.press('right')
            print("Right")
        elif (data == b'\x03'):
            pyautogui.press('down')
            print("Down")
        elif (data == b'\x04'):
            pyautogui.press('left')
            print("Left")
        else:
            print("Unknown!")


