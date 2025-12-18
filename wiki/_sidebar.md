<!-- wiki sidebar using internal css stylesheet -->
<!-- 
using HTML/CSS formatting for code,
Markdown file type for processing
<!DOCTYPE html>
<html lang="en">
-->
<!--   INTERNAL STYLESHEET -->
<head>
  <title>Endeavour OS Beginner Basics</title>

  <!-- ## internal css styling ## -->
  <style>
  :root {
    font-size: 15px;
    line-height: 120%;
  }

  .topic {
    font-size: 103%;
    font-weight: bold;
    text-decoration: underline;
  }
  .subtopics {
    display: block;
    position: left;
    background-color: #08052b;
    color: #bebeff;
  }
  .subtopics summary {
    background-color: #08052b; 
    font-weight: 550;
  }
  .subtopics summary:hover {
    color: #ffffff;
    cursor: context-menu;
    line-height: 105%;
  }
  .subtopics a.active {
    background-color: #000091;
    color: #dfdfff;
    border: 1px dotted #bebeff;
    font-weight: 625;
    line-height: 100%;
  }

  div {
    padding: 2px 0px 2px 10px;
  }
  body {
    font-family: monospace;
    font-size: 100%;
    text-align: left;
    color: #bebeff;
    background-color: #08052b;
    padding-left: 25px;
  }
  body a {
    background-color: #08052b;
    color: #bebeff;
    text-decoration: none;
    padding: 2px;
    display: block;
    text-decoration: none;
  }
  body p {
    padding-left: 5px;
    color: #dfdfff;
  }

  h1 { 
    font-size: 125%;
    }
  hr {
    height: 1px;
    margin-left: 0px;
    width: 80%;
    background-color:#7f7fff;
    border: none;
  }

  a:hover {
    color: #dfdfff;
    background-color: #000091;
    font-size: 105%;
    font-weight: 625;
    text-decoration: underline;
  }
  a:visited {
    color: #7f7fff;
    font-style: italic;
    text-decoration: underline;
  }
  
  details {
    padding: 5px 0px 2px 5px;
  }
  details[open] summary {
    background-color: #000091;
    color: #dfdfff; 
    font-weight: 500;
    padding: 2px;
  }
  summary:hover {
    color: #ffffff;
    background-color: #000091;
    font-size: 103%;
  }
  ul {
    list-style-type: "> ";
    font-size: 95%;
    color: #7f7fff;
  }

  code {
    background-color: #bebeff;
    color: #000091;
    font-size: 95%;
    font-weight: 625;
  }
  code:hover {
    color:#ff7f7f;
    background-color: #000000;
    font-size: 95%;
  }
  </style>
</head>

<!-- SIDEBAR CONTENT START --->
<body>

  <h1>Endeavour OS Beginner Basics</h1>
  <p>
    <a href="https://github.com/mghwajin/eos-basics/wiki">Wiki home</a>
    <a href="https://github.com/mghwajin/eos-basics/blob/main/README.md">README</a>
  </p>
  <hr/>
    
  <a class="topic" href="system-maintenance-overview">System maintenance</a>
  <!-- CLEAR UNUSED SYSTEM FILES -->
  <div>
    <details class="subtopics" open>
      <summary>Clear unused system files</summary>
      <ul>
        <li><a href="clear-pacman-cache">Clear pacman cache</a></li>
        <li><a href="clear-yay-cache">Clear yay</a></li>
        <li><a href="clear-systemd-journal">Clear systemd journal</a></li>
        <li><a href="remove-orphan-dependencies">Remove orphan dependencies</a></li>
      </ul>
    </details>
  </div>
  
  <!-- CREATE SYSTEM BACKUPS WITH TIMESHIFT -->
  <div>
    <details class="subtopics">
      <summary>Create system backups with <code>timeshift</code></summary>
      <ul>
        <li><a href="a "> </a></li>
        <li><a href="a"> </a></li>
        <li><a href="a"> </a></li>
        <li><a href="a"> </a></li>
      </ul>
    </details>
  </div>
  <!-- SYSTEM UPDATES WITH PACMAN AND YAY -->
  <div>
    <details class="subtopics">
      <summary>System updates with <code>pacman</code> and <code>yay</code></summary>
      <ul>
        <li><a href="a "> </a></li>
        <li><a href="a"> </a></li>
        <li><a href="a"> </a></li>
        <li><a href="a"> </a></li>
      </ul>
    </details>
  </div>
  <!-- MIRROR MANAGEMENT GUIDE -->
  <div>
    <details class="subtopics">
      <summary>Mirror maintenance guide</summary>
      <ul>
        <li><a href="a "> </a></li>
        <li><a href="a"> </a></li>
        <li><a href="a"> </a></li>
        <li><a href="a"> </a></li>
      </ul>
    </details>
  </div>
  <!-- RESOLVE CONLIFCTING CONFIG FILES -->
  <div>
    <details class="subtopics">
      <summary>Resolve conflicting config files</summary>
      <ul>
        <li><a href="a "> </a></li>
        <li><a href="a"> </a></li>
        <li><a href="a"> </a></li>
        <li><a href="a"> </a></li>
      </ul>
    </details>
  </div>
  <br/>

  <a class="topic" href="user-tools-and-manuals">User tools and manuals</a>
  <!-- CHANGE LOGIN BACKGROUND -->
  <div>
    <details class="subtopics">
      <summary>Change login background</summary>
      <ul>
        <li><a href="a "> </a></li>
        <li><a href="a"> </a></li>
        <li><a href="a"> </a></li>
        <li><a href="a"> </a></li>
      </ul>
    </details>
  </div>
  <!-- COPY CURSOR SELECTION TO CLIPBOARD -->
  <div>
    <details class="subtopics">
      <summary>Copy cursor selection to keyboard</summary>
      <ul>
        <li><a href="a "> </a></li>
        <li><a href="a"> </a></li>
        <li><a href="a"> </a></li>
        <li><a href="a"> </a></li>
      </ul>
    </details>
  </div>
  <!-- ENABLE THE CRON SCHEDULER -->
  <div>
    <details class="subtopics">
      <summary>Enable the <code>cron</code> scheduler</summary>
      <ul>
        <li><a href="a "> </a></li>
        <li><a href="a"> </a></li>
        <li><a href="a"> </a></li>
        <li><a href="a"> </a></li>
      </ul>
    </details>
  </div>
  <!-- GIT CLONE TO LOCATION -->
  <div>
    <details class="subtopics">
      <summary><code>git clone</code> to location</summary>
      <ul>
        <li><a href="a "> </a></li>
        <li><a href="a"> </a></li>
        <li><a href="a"> </a></li>
        <li><a href="a"> </a></li>
      </ul>
    </details>
  </div>
  <br/>

<hr>
  <p> Official resources</p>
  <ul>
      <li><a href=" ">Endeavour OS homepage</a></li>
      <li><a href=" ">Community forums</a></li>
      <li><a href="https://github.com/endeavouros-team">Official development</a>
      <li><a href=" "></a>Knowledge base</li>
    </ul>
  </details>

 <!---------------------------------------------------->
</body>
</html>

<!-- EOF -->