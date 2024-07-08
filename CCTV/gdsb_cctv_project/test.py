import cv2

for i in range(10):  # 0���� 9���� ī�޶� �ε��� �׽�Ʈ
    cap = cv2.VideoCapture(i)
    if cap.isOpened():
        print(f"ī�޶� {i}���� ���������� ���Ƚ��ϴ�.")
        break
    else:
        print(f"ī�޶� {i}���� �� �� �����ϴ�.")
