#!/usr/bin/env python3

import pygame
import time

# Initialize the mixer module in pygame
pygame.mixer.init()

# Load the MP3 file
song_path = '/home/j1/a_robot_ws/src/auto_start/scripts/one.mp3'
pygame.mixer.music.load(song_path)

# Play the MP3 file
pygame.mixer.music.play()

# Keep the script running until the music finishes
while pygame.mixer.music.get_busy():
    time.sleep(1)  # Wait for the song to finish
