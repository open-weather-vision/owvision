import 'dart:io';

bool started = false;

void set_line(String line) {
  if (started) {
    stdout.write(
      '\x1B[1A\x1B[2K\r',
    ); // Move up 1 line, clear it, and jump to start
  }
  stdout.writeln(line);
  started = true;
}

void append_line(String line) {
  stdout.writeln(line);
}

void clear_all() {
  stdout.write('\x1B[2J\x1B[0;0H');
  started = false;
}

void end() {
  started = false;
}
