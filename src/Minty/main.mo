
// 1) Organize file structure, actor, module, type, class,
//structure factorings as look most manageable / convenient
// starting point from various examples cited

// 2) Review, outline, verify overall interaction
// and processing flows.

// 3) Sketch out declarations and signatures of major components:
//     a) NFT types factored into modules to import as needed
//         depending on applicable standard.  (DRC 721, )
//         DRC 721 recommended for use in project
//         
//         Token content management - what does it contain,
//         is it extensible? etc.

//     b) Core minting rountines - ideally polymorphic and/or
//       composable as where reuse and specialization across
//        standards can be maintained.

//     c) Managing accounts, principals, etc.
//     - id msg content for canister interaction, auth,
//       ownership, (witness?) etc.

//     d) A utils module?  supplementary routines tailored to
//        requirements of main modules/operations.

//     e) Incrementally deploy web frontend as needed
//        - try other frameworks and package managers.
//        - familiarize with packaging (vessel) and config
//        - review changes for incorporating new frameworks and toolchain

//Intermediate Additions:
// - Integrate a Token Transaction into the project
// - Add some kind of Token, Ownership or other relates listings

//Base imports
import Principal "mo:base/Principal";
import Option "mo:base/Option";

//Import Token standard structures - DIP 721 Types
import T_721 "dip721_types";
// Other Token types

// Define the Token API
actor class DRC721(_name : Text, _symbol : Text){
//Stable means that system pre and post upgrade calls will
//persist across canister upgrades

  private stable var tokenPk : Nat = 0;

  private stable var owner_tokens : [(T_721.TokenId, Principal)] = [];
  private stable var owner_balances : [(Principal, Nat)] = [];
  private stable var tokens_content : [(T_721.TokenId, Text)] = [];

//Using Hashmap.Hashmap class <Key , Value> pairs that will grow automatically and grow
// storage, as needed - start with whatever size seems good, including 0
// `get`, `set`, `delete`, `count` and `entries`
// as with the `Buffer` class, no array allocation happens until the first `set`.

// Hashmap clone
// Clone from any iterator of key-value pairs
  // public func fromIter<K, V>(
  //   iter : Iter.Iter<(K, V)>,
  //   initCapacity : Nat,
  //   keyEq : (K, K) -> Bool,
  //   keyHash : K -> Hash.Hash
  // ) : HashMap<K, V> {
  //   let h = HashMap<K, V>(initCapacity, keyEq, keyHash);
  //   for ((k, v) in iter) {
  //     h.put(k, v);
  //   };
  //   h
  // };

// Hashmap map
// public func map<K, V1, V2>(
//     h : HashMap<K, V1>,
//     keyEq : (K, K) -> Bool,
//     keyHash : K -> Hash.Hash,
//     mapFn : (K, V1) -> V2,
//   ) : HashMap<K, V2> {
//     let h2 = HashMap<K, V2>(h.size(), keyEq, keyHash);
//     for ((k, v1) in h.entries()) {
//       let v2 = mapFn(k, v1);
//       h2.put(k, v2);
//     };
//     h2
//   };

// New idea:   public shared({caller}) func(....) - for receiving client owned data 
// Encouraged to apply switch/case stmts to handle all cases of request handling

// switch <exp> { (case <pat> <block-or-exp>;)+ } wth a type T provided


// token minting - Implementation


// Does a token exist at this index in the owner registry
// When minted - tokens are registered with an owner
private func _exists(tokenPk : Nat) : Bool{
  return Option.isSome(owners.get(tokenId));
};

// 
private _incrementbalance(to){

}

// Construct the registry of owned tokens
//Array representationa for purpose of orthogonal presistence (must be Stable Type)
private stable var ownersEntries : [(T_721.TokenId, Principal)] = [];

private let owners : HashMap.HashMap<T_721.TokenId, Principal> = HashMap.fromIter<T_721.TokenId, Principal>(ownersEntries.vals(), 10, Principal.equal, Hash.hash);

//owners-put(tokenPk, to)
//tokenURIs(tokenPk, iri)

private func _mint( to : Principal, tokenPk : Nat, uri : Text ) : (){
  assert not _exists(tokenPk);

  _incrementbalance(to);
  owners.put(tokenId, to);
  tokenURIs.put(tokenPk, uri);
};


// token minting - API/Interface

public shared ({caller}) func mint(uri : Text) : async Nat{
    tokenPk +=1;
    _mint(caller, tokenPk, uri);
    return tokenPk;
};

// token burning - Implementation
// token burning - API/ Interface


};



// Define the Transactions on Tokens








