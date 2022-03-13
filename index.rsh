'reach 0.1';

const Player = {
    getHand: Fun([], UInt),
    seeOutcome: Fun([UInt], Null)
}

export const main = Reach.App(() => {
    // Create participant 1
    const Alice = Participant('Alice', {
        // Alice's Interacting interface Here!
        ...Player,
    })

    // Create Participant 2
    const Bob = Participant('Bob', {
        //  Bob's Interacting interface Here!
        ...Player,
    })
    
    //  Initialize App
    init();

    Alice.only(() => {
        const handAlice = declassify(interact.getHand());   
    })
    
    // Publish Alice's Hand to the consensus network
    Alice.publish(handAlice);
    commit();

    Bob.only(() => {
        const handBob = declassify(interact.getHand())
    })
    // Publish Bob's hand to the consensus network
    Bob.publish(handBob);

    const outcome = (handAlice + (4 - handBob)) % 3;
    commit();
    
    each([Alice, Bob], () => {
        interact.seeOutcome(outcome);
    });
})