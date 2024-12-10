# EC 311 Final Project

## Project Name: Morse Code Trainer

---

### Developers 🎓
This project was developed by a group of Boston University College of Engineering students: **Vugar Amirov** (Computer Engineering (B.S.)), **Lorraine Graham** (Electrical Engineering (B.S.)), **Mahnoor Ghani** (Computer Engineering (B.S.)), and **Ayin Pitman** (Computer Engineering (B.S.))

---

### Project Description 📌

This project is designed to change morse code input to a text which will be displayed on the **7 segment display**. There are **2 input buttons**. One of the buttons is used to **reset** the text which appears on the display. The other button is used as an input for either a **dot, dash, ending of a letter or a space** depending on how many **clock cycles** the button is hold.

---

### How to run the project 💻

- To run the project, please make sure **all files** are in the **same project directory** and then **push the bitstream** to **nexys 7 FPGA**.
- The user can **input** their disired **letter by pressing the input button at pin N17** which will decode it as either dot, dash, ending of a letter or space. There is an **LED at pin ... which blinks every clock cycle** so that the user will be aware for how long the button should be pressed for a dot, dash, ending of a letter, or space.
  - **Dot - 1 clock cycles when button is active**
  - **Dash - 3 clock cycles when button is active**
  - **Space - 7 clock cycles when button is inactive**
  - **Ending of a letter - 3 clock cycles when button is inactive**
- The user can also **reset their input by pressing the input button at pin P17.**
- **After completing the sequence** for the desired letter and **letting the clock run long enough**, the **letter should be displayed on the screen.**

---

### Overview of what the code does ⚙️

![7 Segment Display](https://github.com/user-attachments/assets/e1b5d198-b18b-4b07-9361-414329291dfc)


![Block Diagram](https://github.com/user-attachments/assets/720cb89d-cf42-4faa-a24b-caba0f36659e)

---

### Features (Demo Video) 💻



---

### Contribution 💼

This is an **open source project**. If you would like to **contribute** to the project and **develop** this project, please reach out to us!

---

### Reference (Link) 📄

<details>
<summary>Morse Code</summary>
  
[Morse Code Information](https://www.learnmorsecode.com/)
</details>

<details>
<summary>Verilog</summary>
  
[Vivado Documentation](https://docs.amd.com/r/2021.1-English/ug896-vivado-ip/Vivado-Design-Suite-Documentation)
</details>

<details>
<summary>Badge</summary>
  
[Badges Used](https://github.com/alexandresanlim/Badges4-README.md-Profile)
</details>
