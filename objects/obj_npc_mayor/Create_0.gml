myText = "Welcome to City Hall. I oversee the town's digital transformation. When you've solved all problems, return to me for evaluation.";
itemTextDone = "Thank you for your service! The town is thriving.";
myState = npcState.normal;
has_been_talked_to = false;

// Mayor specific states
mayor_state = 0;  // 0=intro, 1=waiting confirmation, 2=design questions, 3=build, 4=evaluation done
current_question = 0;
design_correct = 0;
build_progress = 0;
confirm_choice = false;
mayorPrompt = noone;