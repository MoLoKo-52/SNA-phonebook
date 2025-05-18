# Phonebook gRPC System

## Server setup

1. Clone the repo using the following command
```bash
git clone https://github.com/MoLoKo-52/SNA-phonebook.git
```
2. Build the docker and run the server

```bash
docker build -t phonebook-server .
docker run -p 50051:50051 phonebook-server                
```


## Flutter Client setup

1. Download the build of the application

[Android (.apk)](https://github.com/MoLoKo-52/SNA-phonebook/releases/download/v1.0.0/app-release.apk)

[MacOS](https://github.com/MoLoKo-52/SNA-phonebook/releases/download/v1.0.0/phonebook_interface.app.zip)

2. Connect to the same WiFi network with host server with Docker and open the application
3. Click on the settings icon in the top right and write there IP of the host mashine

You can check it by command:

```bash
#for MacOS and ubuntu
ip a 
#for Windows
ipconfig
```

Then click apply and if IP is correct - the status should become "connected".

## Usage 
You could find telegram aliases or email adresses of teachers by searching their first and last names.  
The interface allows easy and fast search the contacts and open them in telegram/ mail service - depend on the information, which was officially anounced on the course.  
The teachers, who use communication via telegram or via email, have the different contact information.
