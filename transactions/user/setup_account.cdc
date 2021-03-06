import ChainmonstersRewards from 0xCHAINMONSTERS

// This transaction sets up an account to use Chainmonsters
// by storing an empty NFT collection and creating
// a public capability for it

transaction {

    prepare(acct: AuthAccount) {

        // First, check to see if an NFT collection already exists
        if acct.borrow<&ChainmonstersRewards.Collection>(from: /storage/RewardCollection) == nil {

            // create a new Chainmonsters Collection
            let collection <- ChainmonstersRewards.createEmptyCollection() as! @ChainmonstersRewards.Collection

            // Put the new Collection in storage
            acct.save(<-collection, to: /storage/RewardCollection)

            // create a public capability for the collection
            acct.link<&{ChainmonstersRewards.RewardCollectionPublic}>(/public/RewardCollection, target: /storage/RewardCollection)
        }
    }
}
