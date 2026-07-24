import React from 'react';
import './App.css';

// Mock data arrays for mapping
export const books = [
  { id: 101, bname: 'Master React', price: 670 },
  { id: 102, bname: 'Deep Dive into Angular 11', price: 800 },
  { id: 103, bname: 'Mongo Essentials', price: 450 },
];

export const courses = [
  { id: 201, cname: 'Angular', date: '4/5/2021' },
  { id: 202, cname: 'React', date: '6/3/2020' },
];

export const blogs = [
  { id: 301, title: 'React Learning', author: 'Stephen Biz', desc: 'Welcome to learning React!' },
  { id: 302, title: 'Installation', author: 'Schewzdenier', desc: 'You can install React from npm.' },
];

function App() {
  // Book details list structure using map
  const bookdet = (
    <ul>
      {books.map((book) => (
        <div key={book.id}>
          <h3>{book.bname}</h3>
          <h4>{book.price}</h4>
        </div>
      ))}
    </ul>
  );

  // Course details list structure using map
  const coursedet = (
    <ul>
      {courses.map((course) => (
        <div key={course.id}>
          <h3>{course.cname}</h3>
          <h4>{course.date}</h4>
        </div>
      ))}
    </ul>
  );

  // Blog details list structure using map
  const content = (
    <ul>
      {blogs.map((blog) => (
        <div key={blog.id}>
          <h3>{blog.title}</h3>
          <p><strong>{blog.author}</strong></p>
          <p>{blog.desc}</p>
        </div>
      ))}
    </ul>
  );

  return (
    <div>
      <div className="main-container">
        {/* Course Details Section */}
        <div className="mystyle1">
          <h1>Course Details</h1>
          {coursedet}
        </div>

        {/* Vertical Divider Line */}
        <div className="divider"></div>

        {/* Book Details Section */}
        <div className="st2">
          <h1>Book Details</h1>
          {bookdet}
        </div>

        {/* Vertical Divider Line */}
        <div className="divider"></div>

        {/* Blog Details Section */}
        <div className="v1">
          <h1>Blog Details</h1>
          {content}
        </div>
      </div>
    </div>
  );
}

export default App;