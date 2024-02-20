import tensorflow as tf
from tensorflow.keras import layers, models
from tensorflow.keras.optimizers import Adam
from tensorflow.keras.losses import SparseCategoricalCrossentropy
from tensorflow.keras.callbacks import ModelCheckpoint
from tensorflow.keras.models import load_model
from tensorflow.keras.utils import to_categorical
import numpy as np
import os

# Define dataset paths and classes
train_data_path = "/Dataset/train/data"
val_data_path = "/Dataset/validation/data"
test_data_path = "/Dataset/test/data"
num_classes = 10  # Number of transcription classes

# Define a function to load and preprocess audio data
def preprocess_audio(audio_path):
    # Add your audio preprocessing code here
    return processed_audio_data

# Define a function to load the dataset
def load_dataset(data_path):
    # Load and preprocess the audio data and corresponding labels
    # Here, you can use libraries like librosa to load audio files
    # Make sure to preprocess audio data according to the model requirements
    audio_data = []
    labels = []
    # Example code for loading audio data (you may need to adjust this based on your dataset structure)
    for audio_file in os.listdir(data_path):
        audio_path = os.path.join(data_path, audio_file)
        processed_audio = preprocess_audio(audio_path)
        audio_data.append(processed_audio)
        label = int(audio_file.split("_")[0])  # Assuming filenames are in format "label_audio_file.extension"
        labels.append(label)
    return np.array(audio_data), np.array(labels)

# Load datasets
train_data, train_labels = load_dataset(train_data_path)
val_data, val_labels = load_dataset(val_data_path)
test_data, test_labels = load_dataset(test_data_path)

# Convert labels to one-hot encoding
train_labels = to_categorical(train_labels, num_classes=num_classes)
val_labels = to_categorical(val_labels, num_classes=num_classes)
test_labels = to_categorical(test_labels, num_classes=num_classes)

# Define your own classification head
inputs = tf.keras.Input(shape=(...))  # Define the shape of your preprocessed audio data
x = layers.Conv2D(filters=64, kernel_size=3, activation='relu')(inputs)  # Example convolutional layer
x = layers.MaxPooling2D(pool_size=2)(x)
x = layers.Flatten()(x)
x = layers.Dense(128, activation='relu')(x)
outputs = layers.Dense(num_classes, activation='softmax')(x)

# Create the model
model = models.Model(inputs, outputs)

# Compile the model
model.compile(optimizer=Adam(),
              loss=SparseCategoricalCrossentropy(),
              metrics=['accuracy'])

# Train the model
checkpoint = ModelCheckpoint("best_model.h5", monitor='val_accuracy', verbose=1, save_best_only=True, mode='max')
model.fit(train_data, train_labels, epochs=10, batch_size=32, validation_data=(val_data, val_labels), callbacks=[checkpoint])

# Load the best model
best_model = load_model("best_model.h5")

# Evaluate the model
test_loss, test_acc = best_model.evaluate(test_data, test_labels)
print('Test accuracy:', test_acc)
