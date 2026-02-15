#import "Basic";
#import "tbx/time";

/*

what we want: 
- we set a target frame rate. We have a cicular array which is a history buffer, whenever a frame takes longer than the target frame rate than we will store the frame into this history buffer, we can then look at this frame and figure out why it was slow.

*/

Frame_Profiler :: struct {
    section_timer : Section_Timer;
    // slow_frames : 
    target_frame_rate_hz : u32 = 60;
    target_frame_period : float = 1.0 / 60;
}

start_section :: () {
}

end_section :: () {
    // if duration was longer, then bad. Add that frame to the bad list of frames.
    // need a way to check the history of the thing we just added
    // what if it returned the section or something?
    // or what if we just reached into the history at the history index to get the one we just created.
}


main :: () {
    timer: Section_Timer;
    init_section_timer(*timer);
    
    for frame: 0..100 {
        start_section(*timer, "tick");
        
        start_section(*timer, "update");
        sleep_milliseconds(1);
        end_section(*timer, "update");
        
        start_section(*timer, "rendering");
        sleep_milliseconds(5);
        end_section(*timer, "rendering");
            
        end_section(*timer, "tick");
    }
    
    averaged := get_averaged_sections(*timer);
    print_averaged_section(averaged.root);
}
