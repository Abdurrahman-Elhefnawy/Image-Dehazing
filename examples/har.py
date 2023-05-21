import torch
import torchvision.transforms as transforms
from haar_pytorch import HaarForward, HaarInverse
import cv2
import numpy as np
from torchvision import datasets
import matplotlib.pyplot as plt

haar = HaarForward()
# image = cv2.imread('sam_6.bmp')
# image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)

path = '/media/abdurrahman/Education/Collage/term_10/Optimization/project/imagedehaze/examples'
transform = transforms.ToTensor()


dataset = datasets.ImageFolder(path, transform=transform)
dataloader = torch.utils.data.DataLoader(dataset, batch_size=1)



images, labels = next(iter(dataloader))

print((images.shape))
# tensor = transform(image)

wavelets = haar(images)

ll = wavelets[:,0:3,:,:]
print((ll.shape))
tensor_image = ll.view(ll.shape[2], ll.shape[3], ll.shape[1])

print(type(tensor_image), tensor_image.shape)

# plt.figure() 
# plt.imshow(tensor_image)

image = cv2.cvtColor(tensor_image.numpy(), cv2.COLOR_RGB2BGR)

print(type(image), image.shape)

cv2.imshow("df",image)


cv2.waitKey()
# print(type(wavelets))
# print((wavelets.shape))
# cv2.imshow("sd", wavelets)

