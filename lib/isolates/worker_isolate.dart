import 'dart:developer';
import 'dart:isolate';

// This is the entry point for the isolate.
// It performs a simple task and sends a message back through the SendPort.

void calculateSum(SendPort sendPort) {
  int sum = 0;
  for (int i = 1; i <= 1000000; i++) {
    sum += 1;
  }
  // Send the result back to the main isolate.
  sendPort.send(sum);
}

Future<int> createIsolateAndCalculateSum() async {
// Create a ReceiverPort to receive messages from the worker isolate

  final ReceivePort receivePort = ReceivePort();

// Start the worker isolate and keep a reference to it.
// Pass the SendPort of the ReceiverPort so the worker isolate can send messages back.
  await Isolate.spawn(
    calculateSum,
    receivePort.sendPort,
  );
  // Receiving the result from the worker isolate
  return await receivePort.first as int;
  // Listen for messages from the worker isolate.
  // receivePort.listen((message) {
  //   log(message);

  // Once the message is received, we can close the receive port and stop the isolate.
  // receivePort.close();
  // workerIsolate.kill(priority: Isolate.immediate);
}
