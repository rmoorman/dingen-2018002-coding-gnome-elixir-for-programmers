import HangmanSocket from "./hangman_socket"

window.onload = () => {
  const hangman = new HangmanSocket()
  hangman.connect()
}
