import cv2
import numpy as np



"""""""""""""""
--- Matlab ---
1 -> 193 - 186
2 -> 192 - 201
3 -> 181 - 178
4 -> 233 - 228 
5 -> 238 - 241
6 -> 167 - 165
"""""""""""""""


def compute_atmospheric_light_constant(image, window_size):
    atmosphere_c = []
    # Convert the image to the minimum channel representation
    min_channel = np.min(image, axis=2)
    # Apply a minimum filter to find the local minimum in a window
    kernel = np.ones((window_size, window_size))
    # dark_channel = cv2.erode(min_channel, kernel)
    dark_channel_prior =cv2.erode(min_channel, kernel)
    
    cv2.imshow("dark_channel", dark_channel_prior)

    for i in range(3):
        atmosphere_c.append(np.max(cv2.erode(image[:,:,i], kernel)))
    return atmosphere_c



if __name__ =="__main__":
    image_path = 'sam_6.bmp'
    image = cv2.imread(image_path)
    window_size = 15

    ac = compute_atmospheric_light_constant(image,window_size)

    print(ac)
    cv2.imshow('original Prior', image)
    cv2.waitKey(0)
    cv2.destroyAllWindows()
