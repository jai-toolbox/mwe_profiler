#import "Basic";
#import "tbx/time";
#import "tbx/frame_profiler";

main :: () {

    // why is it on the heap? 
    // because the frame proflier allocates a bunch of storage for its fixed size pools and stuff
    // and it probably won't fit on the stack, on windows it doesn't by default, that's the only reason.

    fp := New(Frame_Profiler);
    defer free(fp);

    init_frame_profiler(fp, target_hz = 1000);  // 1ms target so tiny sleeps register as "slow"
    
    for frame: 0..99 {
        start_frame(fp);
        
            start_section(*fp.section_timer, "update");
                start_section(*fp.section_timer, "physics");
                sleep_milliseconds(0);
                end_section(*fp.section_timer, "physics");
                
                start_section(*fp.section_timer, "ai");
                sleep_milliseconds(0);
                end_section(*fp.section_timer, "ai");
            end_section(*fp.section_timer, "update");
            
            start_section(*fp.section_timer, "render");
            // simulate occasional spike
            if frame % 20 == 10 then sleep_milliseconds(5);
            else sleep_milliseconds(0);
            end_section(*fp.section_timer, "render");
        
        end_frame(fp);
    }
    
    print_profiler_summary(fp);
}
