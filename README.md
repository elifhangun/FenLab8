# FenLab8

# 8th Grade Science Interactive Review – Processing Sketch

This interactive educational tool is built using **Processing 4.3.3** and designed to help 8th-grade students review science topics. The application features multiple pages that introduce two core physics concepts: **Pendulum motion** and **Electric charges**.

## Features

### Page 1: Main Menu
- Title screen introducing the lesson.
- Button to start the pendulum simulation.

### Page 2: Simple Machines – Pendulum
- Interactive pendulum simulation.
- Click and drag the pendulum ball to set it in motion.
- Realistic physics modeled with gravity, angular acceleration, and damping.
- Button to navigate to the electric charges page.

### Page 3: Electricity – Charges
- Visual display of positive and negative electric charges.
- A custom cursor (a positive charge) is repelled or attracted by nearby charges based on polarity.
- Button to return to the main page.
- Sound effect of the charges
---

## Technical Overview

### Pendulum Physics
- Based on angular motion:
  - `angleAcc = (-gravity / ropeLength) * sin(angle)`
  - Angular velocity and damping included.
- Real-time dragging control using mouse input.

### Electric Charges
- Charge class using `PVector` for 2D position.
- Collision distance and repulsion behavior differ based on charge polarity.
- Dynamic cursor position adjusted using vector math.

---

## File Requirements

### Images
Place the following image files in your Processing sketch's `data/` folder:
- `plusv1.png` – image for positive charge and cursor.
- `minusv1.png` – image for negative charge.
- `LEMONMILK-Bold` – font for the ux/ui

> **Note:** All images should be 50×50 pixels or will be resized on load.

---

## How to Run

1. Open the sketch in the Processing IDE.
2. Add `plusv1.png` , `minusv1.png` and `LEMONMILK-Bold`  to the `data/` folder.
3. Click the **Run** button.

---

## Educational Goals

This sketch helps students:
- Visualize the motion of pendulums as part of "Simple Machines."
- Understand attraction and repulsion between electric charges.
- Engage in interactive learning with immediate feedback.

---

## Topics Covered

- Simple harmonic motion
- Newton's laws and gravity
- Electric charge interaction
- Vector operations in physics simulations

---

## License

This project is created for educational purposes. You are free to use, modify, and distribute it with attribution.

