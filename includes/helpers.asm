.importonce

.pseudocommand mov source: dest {
  :_mov 1: source: dest
}

.pseudocommand mov16 source: dest {
  :_mov 2: source: dest
}

.pseudocommand _mov bytes: source: dest {
  .for(var byte_id = 0; byte_id < bytes.getValue(); byte_id++) {
    lda extract_byte_argument(source, byte_id)
    sta extract_byte_argument(dest, byte_id)
  }
}

.function extract_byte_argument(arg, byte_id) {
  .if (arg.getType() == AT_IMMEDIATE) {
    .return CmdArgument(arg.getType(), extract_byte(arg.getValue(), byte_id))
  }
  .return CmdArgument(arg.getType(), arg.getValue() + byte_id)
}

.function extract_byte(value, byte_id) {
  .var bits = byte_id * 8
  .eval value = value >> bits
  .return value & 255
}
