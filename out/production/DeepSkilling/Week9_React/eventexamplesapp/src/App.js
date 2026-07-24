import React, { Component } from 'react';
import './App.css';

class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      count: 5,
      amount: '',
      currency: ''
    };
  }

  // Increment counter and invoke multiple methods
  incrementCount = () => {
    this.setState({ count: this.state.count + 1 });
    this.sayHello();
  };

  sayHello = () => {
    alert("Hello! Member1");
  };

  // Decrement counter
  decrementCount = () => {
    this.setState({ count: this.state.count - 1 });
  };

  // Function taking an argument
  sayWelcome = (message) => {
    alert(message);
  };

  // Synthetic event example
  handlePress = (e) => {
    e.preventDefault();
    alert("I was clicked");
  };

  // Currency Converter Submit Handler
  handleSubmit = (e) => {
    e.preventDefault();
    const convertedAmount = this.state.amount * 80; // Example conversion logic
    alert(`Converting to Euro Amount is ${convertedAmount}`);
  };

  render() {
    return (
      <div style={{ padding: '20px' }}>
        {/* Counter Display */}
        <h2>{this.state.count}</h2>

        {/* Buttons */}
        <button onClick={this.incrementCount}>Increment</button><br /><br />
        <button onClick={this.decrementCount}>Decrement</button><br /><br />
        <button onClick={() => this.sayWelcome("welcome")}>Say welcome</button><br /><br />
        <button onClick={this.handlePress}>Click on me</button>

        {/* Currency Convertor Section */}
        <h1 style={{ color: 'green' }}>Currency Convertor!!!</h1>
        <form onSubmit={this.handleSubmit}>
          <div>
            <label>Amount: </label>
            <input 
              type="text" 
              value={this.state.amount} 
              onChange={(e) => this.setState({ amount: e.target.value })} 
            />
          </div><br />
          <div>
            <label>Currency: </label>
            <input 
              type="text" 
              value={this.state.currency} 
              onChange={(e) => this.setState({ currency: e.target.value })} 
            />
          </div><br />
          <button type="submit">Submit</button>
        </form>
      </div>
    );
  }
}

export default App;