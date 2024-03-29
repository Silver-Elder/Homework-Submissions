//
//  ContentView.swift
//  P6–Animations
//
//  Created by Sterling Jenkins on 1/31/23.
//

import SwiftUI

struct ContentView: View {
    let letters = Array("Hello SwiftUI")
    
    @State private var animationAmount = 1.0
    
    @State private var animationAmount2 = 0.0
    // Now we can make the button use that for its scale effect, by adding this modifier: (see button)
    
    /*
    ...concept one: modifier order matters, because SwiftUI wraps views with modifiers in the order they are applied.

    Concept two is that we can apply an animation() modifier to a view in order to have it implicitly animate changes.

    To demonstrate this, we could modify our button code so that it shows different colors depending on some state. First, we define the state:
     */
    
    @State private var enabled = false
    // We can toggle that between true and false inside our button’s action: (see 3rd button)
    
    @State private var dragAmount = CGSize.zero
    
    @State private var isShowingRed = false
    
    var body: some View {
        print(animationAmount)
        
        /*
         Because we have some non-view code in there, we need to add return before the VStack so Swift understands which part is the view that is being sent back. But adding print(animationAmount) is important, and to see why I’d like you to run the program again and try manipulating the stepper.

         What you should see is that it prints out 2.0, 3.0, 4.0, and so on. At the same time, the button is scaling up or down smoothly – it doesn’t just jump straight to scale 2, 3, and 4. What’s actually happening here is that SwiftUI is examining the state of our view before the binding changes, examining the target state of our views after the binding changes, then applying an animation to get from point A to point B.

         This is why we can animate a Boolean changing: Swift isn’t somehow inventing new values between false and true, but just animating the view changes that occur as a result of the change.
         
         These binding animations use a similar animation() modifier that we use on views, so you can go to town with animation modifiers if you want to:
         */
        
        
        return VStack {
            
            VStack {
                
                Button("Tap Me") {
                    // animationAmount += 1
                }
                .padding(50)
                .background(.red)
                .foregroundColor(.white)
                .clipShape(Circle())
                //.scaleEffect(animationAmount)
                // .blur(radius: (animationAmount - 1) * 3)
                //.animation(.default, value: animationAmount)
                //.animation(.easeOut, value: animationAmount)
                //.animation(.interpolatingSpring(stiffness: 50, damping: 1), value: animationAmount)
                //.animation(.easeInOut(duration: 2).delay(1), value: animationAmount)
                //.animation(.easeInOut(duration: 2).repeatCount(3, autoreverses: true), value: animationAmount)
                .overlay(
                    Circle()
                        .stroke(.red)
                        .scaleEffect(animationAmount)
                        .opacity(2 - animationAmount)
                        .animation(
                            .easeInOut(duration: 1)
                                .repeatForever(autoreverses: false),
                            value: animationAmount
                        )
                )
                // .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: animationAmount)
                .onAppear {
                    animationAmount = 2
                }
                
                /*
                 What we want is for that button to get bigger every time it’s tapped, and we can do that with a new modifier called scaleEffect(). You provide this with a value from 0 up, and it will be drawn at that size – a value of 1.0 is equivalent to 100%, i.e. the button’s normal size.

                 Because we want to change the scale effect value every time the button is tapped, we need to use an @State property that will store a Double. So, please add this property to your view now:
                 */
                // Finally, when the button is tapped we want to increase the animation amount by 1, so use this for the button’s action:
                // ...we can ask SwiftUI to create an implicit animation for our changes so that all the scaling happens smoothly by adding an animation() modifier to the button:
                // That implicit animation takes effect on all properties of the view that change, meaning that if we attach more animating modifiers to the view then they will all change together. For example, we could add a second new modifier to the button, .blur(), which lets us add a Gaussian blur with a special radius – add this before the animation() modifier:
                    // Note: A radius of (animationAmount - 1) * 3 means the blur radius will start at 0 (no blur), but then move to 3 points, 6 points, 9 points, and beyond as you tap the button.
                // We can control the type of animation used by passing in different values to the modifier. For example, we could use .easeOut to make the animation start fast then slow down to a smooth stop:
                /*
                 There are even spring animations, that cause the movement to overshoot then return to settle at its target. You can control the initial stiffness of the spring (which sets its initial velocity when the animation starts), and also how fast the animation should be “damped” – lower values cause the spring to bounce back and forth for longer.

                 For example, this makes our button scale up quickly then bounce:
                 */
                // For more precise control, we can customize the animation with a duration specified as a number of seconds. So, we could get an ease-in-out animation that lasts for two seconds like this:
                    //Note: When we say .easeInOut(duration: 2) we’re actually creating an instance of an Animation struct that has its own set of modifiers. So, we can attach modifiers directly to the animation to add a delay like this: (see .delay)
                // We can also ask the animation to repeat a certain number of times, and even make it bounce back and forward by setting autoreverses to true. This creates a one-second animation that will bounce up and down before reaching its final size:
                    // Note: If we had set repeat count to 2 then the button would scale up then down again, then jump immediately back up to its larger scale. This is because ultimately the button must match the state of our program, regardless of what animations we apply – when the animation finishes the button must have whatever value is set in animationAmount.
                // For continuous animations, there is a repeatForever() modifier that can be used like this:
                
                /*
                 We can use these repeatForever() animations in combination with onAppear() to make animations that start immediately and continue animating for the life of the view.

                 To demonstrate this, we’re going to remove the animation from the button itself and instead apply it an overlay to make a sort of pulsating circle around the button. Overlays are created using an overlay() modifier, which lets us create new views at the same size and position as the view we’re overlaying.

                 So, first add this overlay() modifier to the button before the animation() modifier:
                 */
                /*
                 That makes a stroked red circle over our button, using an opacity value of 2 - animationAmount so that when animationAmount is 1 the opacity is 1 (it’s opaque) and when animationAmount is 2 the opacity is 0 (it’s transparent).

                 Next, remove the scaleEffect() and blur() modifiers from the button and comment out the animationAmount += 1 action part too, because we don’t want that to change any more, and move its animation modifier up to the circle inside the overlay:
                 
                 Note: I’ve switched autoreverses to false, but otherwise it’s the same animation.
                 */
                // Finally, add an onAppear() modifier to the button, which will set animationAmount to 2:
            }
            .padding()
            
            /*
             The animation() modifier can be applied to any SwiftUI binding, which causes the value to animate between its current and new value. This even works if the data in question isn’t really something that sounds like it can be animated, such as a Boolean – you can mentally imagine animating from 1.0 to 2.0 because we could do 1.05, 1.1, 1.15, and so on, but going from “false” to “true” sounds like there’s no room for in between values.

             This is best explained with some working code to look at, so here’s a view with a VStack, a Stepper, and a Button:
             
             */
            
            VStack {
                //Stepper("Scale amount", value: $animationAmount.animation(), in: 1...10)
                Stepper("Scale amount", value: $animationAmount.animation(
                    .easeInOut(duration: 1)
                        .repeatCount(3, autoreverses: true)
                ), in: 1...10)
                    // Tip: With this variant of the animation() modifier, we don’t need to specify which value we’re watching for changes – it’s literally attached to the value it should watch!
                    // These binding animations effectively turn the tables on implicit animations: rather than setting the animation on a view and implicitly animating it with a state change, we now set nothing on the view and explicitly animate it with a state change. In the former, the state change has no idea it will trigger an animation, and in the latter the view has no idea it will be animated – both work and both are important.
                
                // As you can see, the stepper can move animationAmount up and down, and tapping the button will add 1 to it – they are both tied to the same data, which in turn causes the size of the button to change. However, tapping the button changes animationCount immediately, so the button will just jump up to its larger size. In contrast, the stepper is bound to $animationAmount.animation(), which means SwiftUI will automatically animate its changes.
                // Now, as an experiment I’d like you to change the start of the body to this:

                        Spacer()

                        Button("Tap Me") {
                            animationAmount += 1
                        }
                        .padding(20)
                        .background(.red)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .scaleEffect(animationAmount)
                    }
            
            ForEach(0..<10) { _ in
                Spacer()
            }
            
            VStack {
                /*
                 You’ve seen how SwiftUI lets us create implicit animations by attaching the animation() modifier to a view, and how it also lets us create animated binding changes by adding the animation() modifier to a binding, but there’s a third useful way we can create animations: explicitly asking SwiftUI to animate changes occurring as the result of a state change.

                 This still doesn’t mean we create each frame of the animation by hand – that remains SwiftUI’s job, and it continues to figure out the animation by looking at the state of our views before and after the state change was applied.

                 Now, though, we’re being explicit that we want an animation to occur when some arbitrary state change occurs: it’s not attached to a binding, and it’s not attached to a view, it’s just us explicitly asking for a particular animation to occur because of a state change.

                 To demonstrate this, let’s return to a simple button example again:
                 */
                
                Button("Tap Me") {
                    /*
                    withAnimation {
                        animationAmount2 += 360
                    }
                     */
                    withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                        animationAmount2 += 360
                    }
                    enabled.toggle()
                        //Then we can use a conditional value inside the background() modifier so the button is either blue or red:
                        }
                /*
                        .padding(50)
                        .frame(width: 200, height: 200)
                        //.background(.red)
                        .background(enabled ? .blue : .red)
                            //Finally, we add the animation() modifier to the button to make those changes animate:
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
                        .animation(.default, value: enabled)
                            /* NOTE: You can attach the animation() modifier several times, and the order in which you use it matters.
                             
                             To demonstrate this, I’d like you to add this modifier to your button, after all the other modifiers:
                             */
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .rotation3DEffect(.degrees(animationAmount2), axis: (x: 0, y: 1, z: 0))
                */
                /*
                        .frame(width: 200, height: 200)
                        .background(enabled ? .blue : .red)
                        .animation(.default, value: enabled)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
                        .animation(.interpolatingSpring(stiffness: 10, damping: 1), value: enabled)
                */
                .frame(width: 100, height: 100)
                .background(enabled ? .blue : .red)
                .animation(nil, value: enabled)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: enabled ? 30 : 0))
                .animation(.interpolatingSpring(stiffness: 10, damping: 1), value: enabled)
                        
                            /*
                             // [This] will cause the button to move between a square and a rounded rectangle depending on the state of the enabled Boolean.
                             When you run the program, you’ll see that tapping the button causes it to animate between red and blue, but jump between square and rounded rectangle – that part doesn’t animate.

                             Hopefully you can see where we’re going next: I’d like you to move the clipShape() modifier before the animation, like this:
                             
                             //
                             
                             ...now when you run the code both the background color and clip shape animate.

                             So, the order in which we apply animations matters: only changes that occur before the animation() modifier get animated.
                             */
                
                /*
                 When that button is tapped, we’re going to make it spin around with a 3D effect. This requires another new modifier, rotation3DEffect(), which can be given a rotation amount in degrees as well as an axis that determines how the view rotates. Think of this axis like a skewer through your view:

                 If we skewer the view through the X axis (horizontally) then it will be able to spin forwards and backwards.
                 If we skewer the view through the Y axis (vertically) then it will be able to spin left and right.
                 If we skewer the view through the Z axis (depth) then it will be able to rotate left and right.
                 Making this work requires some state we can modify, and rotation degrees are specified as a Double. So, please add this property now: (see animationAmount2)
                 Next, we’re going to ask the button to rotate by animationAmount degrees along its Y axis, which means it will spin left and right. Add this modifier to the button now:
                 */
                /*
                 Now for the important part: we’re going to add some code to the button’s action so that it adds 360 to animationAmount every time it’s tapped.

                 If we just write animationAmount += 360 then the change will happen immediately, because there is no animation modifier attached to the button. This is where explicit animations come in: if we use a withAnimation() closure then SwiftUI will ensure any changes resulting from the new state will automatically be animated.

                 So, put this in the button’s action now:
                 */
                
                /*
                 Run that code now and I think you’ll be impressed by how good it looks – every time you tap the button it spins around in 3D space, and it was so easy to write. If you have time, experiment a little with the axes so you can really understand how they work. In case you were curious, you can use more than one axis at once.

                 withAnimation() can be given an animation parameter, using all the same animations you can use elsewhere in SwiftUI. For example, we could make our rotation effect use a spring animation using a withAnimation() call like this:
                 */
                
                /*
                 ...if we apply multiple animation() modifiers, each one controls everything before it up to the next animation. This allows us to animate state changes in all sorts of different ways rather than uniformly for all properties.

                 For example, we could make the color change happen with the default animation, but use an interpolating spring for the clip shape:
                 */
                
                /*
                 You can have as many animation() modifiers as you need to construct your design, which lets us split one state change into as many segments as we need.

                 For even more control, it’s possible to disable animations entirely by passing nil to the modifier. For example, you might want the color change to happen immediately but the clip shape to retain its animation, in which case you’d write this:
                 
                 //
                 
                 That kind of control wouldn’t be possible without multiple animation() modifiers – if you tried to move background() after the animation you’d find that it would just undo the work of clipShape().

                 */
                
                
                // ...let’s try something relatively simple: a card that we can drag around the screen, but when we let go it snaps back into its original location. First, our initial layout:
                LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            .frame(width: 300, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .offset(dragAmount)
                            .gesture(
                                DragGesture()
                                    .onChanged { dragAmount = $0.translation }
                                    //.onEnded { _ in dragAmount = .zero }
                                    .onEnded { _ in
                                        withAnimation(.spring()) {
                                            dragAmount = .zero
                                        }
                                    }
                            )
                            //.animation(.spring(), value: dragAmount)
                    /*
                     We want to move that around the screen based on the location of our finger, and that requires three steps.

                     First, we need some state to store the amount of their drag: (see @state dragAmount)
                     
                     
                     Second, we want to use that size to influence the card’s position on-screen. SwiftUI gives us a dedicated modifier for this called offset(), which lets us adjust the X and Y coordinate of a view without moving other views around it. You can pass in discrete X and Y coordinates if you want to, but – by no mere coincidence – offset() can also take a CGSize directly.

                     So, step two is to add this modifier to the card gradient:
                     
                     //
                     
                     Now comes the important part: we can create a DragGesture and attach it to the card. Drag gestures have two extra modifiers that are useful to us here: onChanged() lets us run a closure whenever the user moves their finger, and onEnded() lets us run a closure when the user lifts their finger off the screen, ending the drag.

                     Both of those closures are given a single parameter, which describes the drag operation – where it started, where it is currently, how far it moved, and so on. For our onChanged() modifier we’re going to read the translation of the drag, which tells us how far it’s moved from the start point – we can assign that directly to dragAmount so that our view moves along with the gesture. For onEnded() we’re going to ignore the input entirely, because we’ll be setting dragAmount back to zero.

                     So, add this modifier to the linear gradient now:
                     
                     //
                     
                     If you run the code you’ll see you can now drag the gradient card around, and when you release the drag it will jump back to the center. The card has its offset determined by dragAmount, which in turn is being set by the drag gesture.

                     Now that everything works we can bring that movement to life with some animation, and we have two options: add an implicit animation that will animate the drag and the release, or add an explicit animation to animate just the release.

                     To see the former in action, add this modifier to the linear gradient:
                     
                     //
                     
                     As you drag around, the card will move to the drag location with a slight delay because of the spring animation, but it will also gently overshoot if you make sudden movements.

                     To see explicit animations in action, remove that animation() modifier and change your existing onEnded() drag gesture code to this:
                     
                     //
                     
                     Now the card will follow your drag immediately (because that’s not being animated), but when you release it will animate.

                     If we combine offset animations with drag gestures and a little delay, we can create remarkably fun animations without a lot of code.

                     To demonstrate this, we could write the text “Hello SwiftUI” as a series of individual letters, each one with a background color and offset that is controlled by some state. Strings are just slightly fancy arrays of characters, so we can get a real array from a string like this: Array("Hello SwiftUI").

                     Anyway, try this out and see what you think: (see HStack)
                     */
                
            }
            Spacer()
            
            // If you run that code (vvv) you’ll see that any letter can be dragged around to have the whole string follow suit, with a brief delay causing a snake-like effect. SwiftUI will also add in color changing as you release the drag, animating between blue and red even as the letters move back to the center.
            
            HStack(spacing: 0) {
                        ForEach(0..<letters.count, id: \.self) { num in
                            Text(String(letters[num]))
                                .padding(5)
                                .font(.title)
                                .background(enabled ? .blue : .red)
                                .offset(dragAmount)
                                .animation(.default.delay(Double(num) / 20), value: dragAmount)
                        }
                    }
                    .gesture(
                        DragGesture()
                            .onChanged { dragAmount = $0.translation }
                            .onEnded { _ in
                                dragAmount = .zero
                                enabled.toggle()
                            }
                    )
            
            /*
             One of the most powerful features of SwiftUI is the ability to customize the way views are shown and hidden. Previously you’ve seen how we can use regular if conditions to include views conditionally, which means when that condition changes we can insert or remove views from our view hierarchy.

             Transitions control how this insertion and removal takes place, and we can work with the built-in transitions, combine them in different ways, or even create wholly custom transitions.

             To demonstrate this, here’s a VStack with a button and a rectangle:
             */
            
            VStack {
                Button("Tap Me") {
                    withAnimation {
                        isShowingRed.toggle()
                    }
                }
                
                /*
                Rectangle()
                    .fill(.red)
                    .frame(width: 50, height: 50)
                 */
                
                if isShowingRed {
                    Rectangle()
                        .fill(.red)
                        .frame(width: 50, height: 50)
                        //.transition(.scale)
                        .transition(.asymmetric(insertion: .scale, removal: .opacity))
                }
                /* We can make the rectangle appear only when a certain condition is satisfied. First, we add some state we can manipulate: (see @State isShowingRed)
                 
                 //
                 
                 Next we use that state as a condition for showing our rectangle:
                 
                 //
                 
                 Finally we can toggle isShowingRed between true and false in the button’s action:
                 
                 //
                 
                 If you run the program, you’ll see that pressing the button shows and hides the red square. There’s no animation; it just appears and disappears abruptly.

                 We can get SwiftUI’s default view transition by wrapping the state change using withAnimation(), like this:
                 
                 //
                 
                 With that small change, the app now fades the red rectangle in and out, while also moving the button up to make space. It looks OK, but we can do better with the transition() modifier.

                 For example, we could have the rectangle scale up and down as it is shown just by adding the transition() modifier to it:
                 
                 //
                 
                 Now tapping the button looks much better: the rectangle scales up as the button makes space, then scales down when tapped again.

                 There are a handful of other transitions you can try if you want to experiment. A useful one is .asymmetric, which lets us use one transition when the view is being shown and another when it’s disappearing. To try it out, replace the rectangle’s existing transition with this:
                 */
                
                ZStack {
                    Rectangle()
                        .fill(.blue)
                        .frame(width: 30, height: 30)
                    if isShowingRed {
                        Rectangle()
                            .fill(.red)
                            .frame(width: 30, height: 30)
                            .transition(.pivot)
                    }
                }
                .onTapGesture {
                    withAnimation {
                        isShowingRed.toggle()
                    }
                }
            }
        } .padding()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


/*
 It’s possible – and actually surprisingly easy – to create wholly new transitions for SwiftUI, allowing us to add and remove views using entirely custom animations.

 This functionality is made possible by the .modifier transition, which accepts any view modifier we want. The catch is that we need to be able to instantiate the modifier, which means it needs to be one we create ourselves.

 To try this out, we could write a view modifier that lets us mimic the Pivot animation in Keynote – it causes a new slide to rotate in from its top-left corner. In SwiftUI-speak, that means creating a view modifier that causes our view to rotate in from one corner, without escaping the bounds it’s supposed to be in. SwiftUI actually gives us modifiers to do just that: rotationEffect() lets us rotate a view in 2D space, and clipped() stops the view from being drawn outside of its rectangular space.

 rotationEffect() is similar to rotation3DEffect(), except it always rotates around the Z axis. However, it also gives us the ability to control the anchor point of the rotation – which part of the view should be fixed in place as the center of the rotation. SwiftUI gives us a UnitPoint type for controlling the anchor, which lets us specify an exact X/Y point for the rotation or use one of the many built-in options – .topLeading, .bottomTrailing, .center, and so on.

 Let’s put all this into code by creating a CornerRotateModifier struct that has an anchor point to control where the rotation should take place, and an amount to control how much rotation should be applied:
 */

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint

    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
                // The addition of clipped() there means that when the view rotates the parts that are lying outside its natural rectangle don’t get drawn.
    }
}
    // We can try [this] (^^^) straight away using the .modifier transition, but it’s a little unwieldy. A better idea is to wrap that in an extension to AnyTransition, making it rotate from -90 to 0 on its top leading corner:

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}

/* With that in place we now attach the pivot animation to any view using this:

 .transition(.pivot)
 
 For example, we could use the onTapGesture() modifier to make a red rectangle pivot onto the screen, like this:
 */
