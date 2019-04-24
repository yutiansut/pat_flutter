# PAT_flutter

#Flutter Installation 

Step - 1:
        Install Android studio latest version

Step - 2: 
        Install Open-JDK by using following command
        command:
            $ sudo apt install openjdk-8-jre openjdk-8-jdk

Step - 3: 
        Set the Environment Variables in .bashrc file.
        Following lines:
            export ANDROID_HOME=$HOME/Android/Sdk
            export PATH=$PATH:$ANDROID_HOME/emulator
            export PATH=$PATH:$ANDROID_HOME/tools
            export PATH=$PATH:$ANDROID_HOME/tools/bin
            export PATH=$PATH:$ANDROID_HOME/platform-tools
            export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64/
            export PATH=$PATH:JAVA_HOME
            export PATH=$PATH:/home/saasmate/BALAWRK/Flutter/flutter/bin
            
Step - 4:
    Clone the Fultter Framework by using following command:
        command:
            $ git clone -b master https://github.com/flutter/flutter.git

Step - 5:
    Install dart SDK by following command
        command:
            $ cd flutter_path
            $ cd bin
            $ ./flutter --version
    
    This will install the Dart SDK

Step - 6: 
    Setup the Flutter Global access point by adding the flutter in root by set Environment varibale
        command:
            $ sudo nano ~/.bashrc
        
            sub-step-6.1: 
                Adding the following line:
                export PATH=$PATH:/home/saasmate/BALAWRK/Flutter/flutter/bin

Step - 7: 
    Install all the Flutter Dependecies by using following command
        command:
            $ flutter doctor

Step - 8: 
    Create the Flutter Project by using following command
        command:
            $ cd wokspace
            $ flutter create project_name

Step - 9:
     Run the Flutter project
        command:
            $ flutter run

     Note:
           Before run the above command you should connect android device or any anroid emulator to the System.

