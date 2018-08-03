/* file: photoBot.ch
 * Create a program that controls a linkbot
 * based on the values of the photoresistor.
 * LEDs (red, yellow, or green) turn on
 * depending on the linkbot's motion.
 * Coded partially by Tarang L
 */
 
 #include <arduino.h>
 #include <linkbot.h>
 
 CLinkbotI robot;
 
 double radius = 1.75;
 double speed = 0;
 int photoSensorVal;
 int greenLEDpin = 5,
    redLEDpin = 3,
    yellowLEDpin = 4,
    photoPin = A0,
    photoVal = 0;

// Set pin modes
pinMode(redLEDpin, OUTPUT);
pinMode(greenLEDpin, OUTPUT);
pinMode(yellowLEdpin, OUTPUT);
pinMode(photoPin, INPUT);

// Initialize speed (as 0) and start robot driving
robot.setSpeed(0, radius);
robot.driveForwardNB();

// Retrieve and convert photosensor value, print it, and set robot speed & LEDs
while(1){
    // Retrieve value from photosensor and print
    photoSensorVal = analogRead(photoPin);
    printf("%d", photoSensorVal);
    
    // Convert photosensor value into speed from 0 to 5 and print
    speed = ((double)photoSensorVal/884)*5;
    printf(", %.2lf\n", speed);
    
    // Set speed to zero if it is lower than 1.5
    if(speed < 1.5){
        speed = 0;
    }
    
    robot.setSpeed(speed, radius);
    
    // Change LEDs
    if(speed == 0){
        digitalWrite(redLEDpin, HIGH);
        digitalWrite(yellowLEDpin, LOW);
        digitalWrite(greenLEDpin, LOW);
    }
    else if(speed > 1.5 && speed < 3){
        digitalWrite(redLEDpin, LOW);
        digitalWrite(yellowLEDpin, HIGH);
        digitalWrite(greenLEDpin, LOW);
    }
    else{
        digitalWrite(redLEDpin, LOW);
        digitalWrite(yellowLEDpin, LOW);
        digitalWrite(greenLEDpin, HIGH);
    }
    
    // Delay for accuracy
    delay(100);
}
