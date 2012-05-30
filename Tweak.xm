
// Logos by Dustin Howett
// See http://iphonedevwiki.net/index.php/Logos


BOOL hax;
BOOL shouldPause;
 
%hook WordGameDictionary

- (_Bool)isValidWord:(id)fp8
{
     if(%orig)
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
        
        while(shouldPause)
        {
            [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.0]];
        }
        
        return hax;
    }
}
    %new
    - (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
        shouldPause = false;
        if (buttonIndex == 0) {
            hax =  false;
        }
        if (buttonIndex == 1) {
            hax = true;
        }
            

    }

%end



%hook WordGame

- (int)isValidMove:(id)fp8
{
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
        
        return hax;
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
        hax =  3;
    }
    if (buttonIndex == 1) {
        hax = 4;
    }
    
    
}

%end
