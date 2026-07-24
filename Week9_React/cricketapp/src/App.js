import React from "react";

import ListofPlayers from "./components/ListofPlayers";
import Scorebelow70 from "./components/Scorebelow70";

import OddPlayers from "./components/OddPlayers";
import EvenPlayers from "./components/EvenPlayers";

import ListofIndianPlayers from "./components/ListofIndianPlayers";


function App(){


let flag=true;


const players=[
{name:"Jack",score:90},
{name:"Michael",score:70},
{name:"John",score:40},
{name:"Amn",score:61},
{name:"Elizabeth",score:61},
{name:"Jadeja",score:64},
{name:"Sachin",score:95},
{name:"Dhoni",score:100},
{name:"Virat",score:84},
{name:"Yuvraj",score:64},
{name:"Raina",score:75}
];


const IndianTeam=[
"Sachin",
"Dhoni",
"Virat",
"Rohit",
"Raina"
];


return(

<div>

{
flag ?

<div>

<ListofPlayers players={players}/>

<Scorebelow70 players={players}/>

</div>


:

<div>

<OddPlayers players={IndianTeam}/>

<EvenPlayers players={IndianTeam}/>

<ListofIndianPlayers/>

</div>

}


</div>

)

}


export default App;