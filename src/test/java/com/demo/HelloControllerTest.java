package com.demo;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class HelloControllerTest {
    
    @Test
    public void testHelloMessage() {
        HelloController controller = new HelloController();
        String result = controller.hello();
        assertNotNull(result);
        assertTrue(result.contains("DevOps"));
    }
}
