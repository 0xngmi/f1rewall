FROM python:3.8-slim

# Set environment variables for application configuration
ENV recaptcha_public=$RECAPTCHA_PUBLIC \
    recaptcha_private=$RECAPTCHA_PRIVATE \
    discord_welcome_room=$DISCORD_WELCOME_ROOM \
    discord_private=$DISCORD_PRIVATE \
    image_background=$IMAGE_BACKGROUND \
    image_wordmark=$IMAGE_WORDMARK \
    PORT=$PORT

# Create a system group named "docker"
RUN groupadd -r docker

# Create a system user named "docker"
RUN useradd -m -r -g docker docker

# Set the working directory
WORKDIR /app

# Change the ownership of the working directory to the non-root user "docker"
RUN chown -R docker:docker /app

# Switch to the "docker" user
USER docker

# Copy the necessary files
COPY etc ./etc
COPY templates ./templates
COPY app.py ./app.py
COPY requirements.txt ./requirements.txt
COPY server.py ./server.py

# Install the required dependencies
RUN python -m pip install --user -r requirements.txt

# Set the command to run the server
CMD ["python", "./server.py"]
