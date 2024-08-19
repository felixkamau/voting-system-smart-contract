const {expect} = require("chai");


describe("Voting", function () {
    let Voting;
    let voting;
    let owner;
    let addr1;
    let addr2;
    let addrs;


    beforeEach(async function (){
        // get signer and contract factory
        Voting = await ethers.getContractFactory("Voting");
        [owner, addr1, addr2, ...addrs] = await ethers.getSigners();


        // Deploy a new VotingSystem contract before each test.
        voting = await Voting.deploy(["Alice", "Bob"]);
        // console.log(voting);
    });

    describe("Deployment", function () {
        it("Should deploy with the correct initial candidates", async function () {
          const candidate1 = await voting.candidates(0);
          const candidate2 = await voting.candidates(1);
    
          expect(candidate1.name).to.equal("Alice");
          expect(candidate2.name).to.equal("Bob");
        });
      });
    
      describe("Voting", function () {
        it("Should allow users to vote and update vote counts", async function () {
          await voting.startVoting();
    
          await voting.connect(addr1).vote(0); // addr1 votes for candidate 0
          await voting.connect(addr2).vote(0); // addr2 votes for candidate 0
    
          const candidate = await voting.candidates(0);
          expect(candidate.voteCount).to.equal(2);
        });
    
        it("Should not allow voting if voting is not active", async function () {
          await expect(voting.connect(addr1).vote(0)).to.be.revertedWith("Voting is not active");
        });
      });
    
      describe("Winner Determination", function () {
        it("Should return the correct winner after voting ends", async function () {
          await voting.startVoting();
          await voting.connect(addr1).vote(0);
          await voting.connect(addr2).vote(0);
          await voting.endVoting();
    
          const winner = await voting.getWinner();
          expect(winner).to.equal("Alice");
        });
      });
});