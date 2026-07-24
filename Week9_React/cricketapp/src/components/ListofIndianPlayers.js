import React from "react";


function ListofIndianPlayers(){

const T20Players=[
    "First Player",
    "Second Player",
    "Third Player"
];


const RanjiPlayers=[
    "Fourth Player",
    "Fifth Player",
    "Sixth Player"
];


const IndianPlayers=[
    ...T20Players,
    ...RanjiPlayers
];


return(
<div>

<h1>List of Indian Players Merged:</h1>

<ul>
{
IndianPlayers.map((player,index)=>(
<li key={index}>
Mr. {player}
</li>
))
}
</ul>


</div>
)

}

export default ListofIndianPlayers;