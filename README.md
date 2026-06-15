# 🚚 TruckRacers.sol               
            
> 🏁 **On-chain truck racing game in Solidity — no tokens, no rewards, just pure fun.**        
        
![Truck Racing Banner](https://user-images.githubusercontent.com/your-banner-image.jpg) <!-- можешь заменить или удалить -->           
           
---                     
        
## 🎮 About the Game          
           
**TruckRacers** is a minimalist, turn-based racing game for two players on the Ethereum blockchain.       
           
- Players race by moving their trucks forward one cell at a time.      
- First to reach the finish line wins.     
- Fully on-chain logic, no off-chain dependencies.       
- No tokens, no bets, no rewards — just code and competition.     
         
---    
      
## 🔧 How It Works
    
1. **Player 1** creates a new game.   
2. **Player 2** joins the game.       
3. Players take turns calling `move()` to race forward.   
4. The first to reach cell `10` is the winner.     
   
Each move is recorded on-chain. Results are transparent and immutable.   

---  

## 🧠 Smart Contract Overview

- Language: **Solidity ^0.8.24** 
- Game logic is stored entirely on-chain. 
- Turn-based: players alternate moves.   
- Secure access control (no cheating possible).
- Winner is automatically determined.

---

## 🚀 Deployment & Testing

To test or deploy the contract, use [Foundry](https://book.getfoundry.sh/) or [Hardhat](https://hardhat.org/).

### Foundry (recommended)

```bash
forge init truck-racers
cd truck-racers
# Add this file to src/TruckRacers.sol
forge build
forge test
