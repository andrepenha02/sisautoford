// Definição do pino onde o microswitch está conectado
const int microswitchPin = 2; // Pino digital 2

void setup() {
  // Configura o pino como entrada com resistor de pull-up interno
  pinMode(microswitchPin, INPUT_PULLUP);
  // Inicializa a comunicação serial
  Serial.begin(9600);
  Serial.println("...");  
  Serial.println("...");  
  Serial.println("...");  
  Serial.println("Fenomenos de Transporte");  
  Serial.println("Automacao para Medicao de Viscosidade com Copo Ford");  
  Serial.println("Inicializando...");  
  pinMode(13,OUTPUT);
  digitalWrite(13,1);
  delay(1000);
  digitalWrite(13,0);
  delay(1000);
  digitalWrite(13,1);
  delay(1000);
  digitalWrite(13,0);
  delay(1000);
  digitalWrite(13,1);
  delay(1000);
  digitalWrite(13,0);
  delay(1000);
  Serial.println("...");  
  Serial.println("...");  
  Serial.println("...");   
  Serial.println("...");  
  Serial.println("...");  
  Serial.println("...");  

  
}

void loop() {
  // Lê o estado do microswitch
  int switchState = digitalRead(microswitchPin);
  
  // Verifica o estado e escreve na serial
  if (switchState == HIGH) {
    Serial.println("O");
    digitalWrite(13,0);
    delay(10);
  } else {
    Serial.println("C");
    digitalWrite(13,1);    
    delay(10);
}

  // Adiciona um pequeno atraso para evitar sobrecarregar a serial
  delay(100);
}
