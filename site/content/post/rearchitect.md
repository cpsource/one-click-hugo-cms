---
title: 'The Case where Re-Architecture saves the day.'
date: 2022-01-29T14:15:00.000Z
draft: false
description: >-
  In this case, I had to re-architect the design and then re-implement to get it done.
---

## I was called in

As usual, I was called in because the project was late. They were using a number of Linux based FPGAs to build an intercom system for an ocean-going vessel. The advantage to the ship owner was that they only had to run one Ethernet wire for each intercom station, thus saving installation cost and conduit space.

The prime had subcontracted the work to a small development house of about five engineers.

What I found was shocking. The project was in final acceptance, which is to say the customer was expecting them to ship the product for installation that very week. They had all the nodes laid out on a table and they were attempting to have one node ***talk*** to another. You'd talk into one of the nodes, but the other node would sputter. Bits of the verbal content would come out, then a pause, then another bit.

> I was supposed to get this to work, and by Friday, so they could ship it?

## The Problem
On the surface, the design seemed plausible. One of the nodes would perform the A->D, and then transmit a UDP packet to the other node, who would then perform the D->A and output the result to a speaker.

To get this to happen within Linux however, the A->D would get a packet into kernel space. This was then copied into user space, and a small application would then copy this back into kernel space and transmit the message. The reverse would have to happen at the other end.

This was a lot of copies, and clearly the FPGA design didn't run fast enough to keep up, hence the sputtering.

> Obviously, they had not sand-boxed the design early-on to spot this performance issue.

The manager at prime was apoplectic, burned-out, and was tired stalling the customer. He just wanted the project done, and shipped.

# The Solution

'Ok', I said. We have to re-architect the design to do everything in kernel space. Since we had the kernel sources, it was a simple matter to make the necessary modification. It took about a week for me to recode it, and voilà, it passed final test.

## The subcontractor now had the knives out for me.

I had done in a week what they had billed six months times six engineers time to complete.

I went to the manager with this and he was too burned out to care. I wanted the sub thrown out the door.

## There were other problems

### Human Factors

Their hardware design would have never passed human factors. The display on the device should have been able to be seen in direct sunlight, but they hadn't used a trans-reflective display technology. You had to hold your had over it to read the menu items.

Additionally, it was a touch screen and had a menu depth of about three items you had to click on to select various receiving stations. This would take too much time in a critical situation to be useful.

### Mechanical Design

There was not adequate strain-relief for the wires coming into the unit. 

There was not a watertight seal for the wires coming in. Further, during installation, they had to open the box, which meant salt air and salt spray on the water's surface would get into the electronics and cause corrosion.

Any electronics used in such a harsh environment (marine) needs to be coated with a sealant, which was not done.

As a stop-gap, I suggested they add some silica-gel packs to the innards before they closed the lid, which they did. But this is hardly a long-term solution.

## They brought on a second contractor
This guy started the same week as I did. His task was to write interface code to receive raw terminal data on Linux.

As a gesture, I gave him a 100 line 'C' program that did this. All he had to do was add a wrapper and check it in. Did he? No, he rejected my offer and tried a different technique. A month goes by and nothing. 

Finally, he comes back to me and says he gives up. Again, I pointed him to the code I had given him.
This sort of thing drives me crazy. I hate watching arrogant incompetent contractors flounder. I honestly tried to help him.

## How the U.S. Navy Does It
When I first graduated from college, I worked with a number of ex-navy submariners. They'd tell me stories of dragging electronics by the interface cables down ladders. They figured if the electronics didn't survive that, it'd never survive the cruse.

## Lessons Learned
1. The customer did not sand-box their design to spot any potential problems. 
2. Poor to no human factors. I don't think the customer thought about this at all when they started the project.
3. Poor mechanical design. The customer was unfamiliar with what's required in a marine environment.
4. Inadequate project management.
5. Incomplete knowledge of the Linux kernel. Any design MUST understand the limits of the hardware BEFORE implementation.
6. Poor customer interaction. The customer was unfamiliar with the current state of the project. They had been told the project was in final testing, when clearly it was not.

## Oh well, C'est La Vie
My contract ended and I went on to help other customers.




















