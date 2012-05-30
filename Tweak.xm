
// Logos by Dustin Howett
// See http://iphonedevwiki.net/index.php/Logos


BOOL chooseValue;
BOOL shouldPause;
 
%hook WordGameDictionary //Hanging With Friends Part

- (_Bool)isValidWord:(id)fp8 
{
     if(%orig) // if the word is spelled right, then return true
        {
            return true;
        }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Not A Valid Word!" message:@"Play It Anyway?" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
        [alert addButtonWithTitle:@"No"];
         [alert addButtonWithTitle:@"Yes"];
        [alert show];
        [alert release];
        shouldPause = true;
        
        while(shouldPause) //needed to do this so you could choose what happened before it returned
        {
            [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.0]];
        }
        
        return chooseValue;
    }
}
    %new
    //what happens when the button is hit
    - (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex { 
        shouldPause = false;
        if (buttonIndex == 0) //NO{
            chooseValue =  false;
        }
        if (buttonIndex == 1)//YES {
            chooseValue = true;
        }
            

    }

%end



%hook WordGame //Words With Friends Part

- (int)isValidMove:(id)fp8
{

/*
  if i remember right...
  1= place a tile on board
  2=not valid tile placement
  3=sorry, is not a valid word
  4=valid word, goes to sending
  */
    int original = %orig;
    
    
    if(original != 4) 
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Not A Valid Move!" message:@"Play It Anyway?" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
        [alert addButtonWithTitle:@"No"];
        [alert addButtonWithTitle:@"Yes"];
        [alert show];
        [alert release];
        shouldPause = true;
        
        while(shouldPause)
        {
            [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.0]];
        }
        
        return chooseValue;
    }
    
    else
    {
        return 4;
    }
}


%new
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    shouldPause = false;
    if (buttonIndex == 0) {
        chooseValue =  3;
    }
    if (buttonIndex == 1) {
        chooseValue = 4;
    }
    
    
}

%end
