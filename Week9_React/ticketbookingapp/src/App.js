import React, { Component } from 'react';
import './App.css';

// Login Button Component
function LoginButton(props) {
  return (
    <button onClick={props.onClick}>
      Login
    </button>
  );
}

// Logout Button Component
function LogoutButton(props) {
  return (
    <button onClick={props.onClick}>
      Logout
    </button>
  );
}

// Guest Greeting Component
function GuestGreeting() {
  return (
    <div style={{ padding: '40px' }}>
      <h1>Please sign up.</h1>
    </div>
  );
}

// User Greeting Component
function UserGreeting() {
  return (
    <div style={{ padding: '40px' }}>
      <h1>Welcome back</h1>
    </div>
  );
}

// Greeting Selector Component
function Greeting(props) {
  const isLoggedIn = props.isLoggedIn;
  if (isLoggedIn) {
    return <UserGreeting />;
  }
  return <GuestGreeting />;
}

// Main App Component with State Handling
class App extends Component {
  constructor(props) {
    super(props);
    this.handleLoginClick = this.handleLoginClick.bind(this);
    this.handleLogoutClick = this.handleLogoutClick.bind(this);
    this.state = { isLoggedIn: false };
  }

  handleLoginClick() {
    this.setState({ isLoggedIn: true });
  }

  handleLogoutClick() {
    this.setState({ isLoggedIn: false });
  }

  render() {
    const isLoggedIn = this.state.isLoggedIn;
    let button;

    if (isLoggedIn) {
      button = <LogoutButton onClick={this.handleLogoutClick} />;
    } else {
      button = <LoginButton onClick={this.handleLoginClick} />;
    }

    return (
      <div style={{ padding: '20px' }}>
        <Greeting isLoggedIn={isLoggedIn} />
        <div style={{ marginLeft: '40px' }}>
          {button}
        </div>
      </div>
    );
  }
}

export default App;