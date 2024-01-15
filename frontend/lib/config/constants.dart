const wordsPerToken = 5000;

double getPlayerGamePrice(int playerWordCount, int AIWordCount, int numberOfPlayers)  {
  return (playerWordCount + AIWordCount / numberOfPlayers) / wordsPerToken;
}
