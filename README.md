# PAT_flutter

#Flutter Installation 

1. Install Android studio latest version

2. Install Open-JDK by using following command
    command:
        $ sudo apt install openjdk-8-jre openjdk-8-jdk

3. Set the Environment Variables in .bashrc file.
    Following lines:
        export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64/
        export PATH=/home/saasmate/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/saasmate/Android/Sdk/emulator:/home/saasmate/Android/Sdk/too$
        export PATH=$PATH:JAVA_HOME

4. Clone the Fultter Framework by using following command:
    command:
        $ git clone -b master https://github.com/flutter/flutter.git

5. Install dart SDK by following command
    command:
        $ cd flutter_path
        $ cd bin
        $ ./flutter --version
    
    This will install the Dart SDK

6. Setup the Flutter Global access point by adding the flutter in root by set Environment varibale
    command:
        $ sudo nano ~/.bashrc
        
        --- Adding the following line:
        export PATH=$PATH:/home/saasmate/BALAWRK/Flutter/flutter/bin

7. Install all the Flutter Dependecies by using following command
    command:
        $ flutter doctor

8. Create the Flutter Project by using following command
    command:
        $ cd wokspace
        $ flutter create project_name

9. Run the Flutter project
    command:
        $ flutter run

    Note:
        Before run the above command you should connect android device or any anroid emulator to the System.

