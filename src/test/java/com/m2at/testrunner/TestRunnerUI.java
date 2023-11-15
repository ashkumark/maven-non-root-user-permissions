package com.m2at.testrunner;

import io.cucumber.junit.Cucumber;
import io.cucumber.junit.CucumberOptions;
import org.junit.runner.RunWith;


@RunWith(Cucumber.class)
@CucumberOptions(
		features = "classpath:features", 
		glue = { "com.m2at.glue" }, 
		plugin = {"pretty", "json:target/cucumber-ui.json",
				  "html:target/cucumber-html-report/regression-tests.html",
				  "com.aventstack.extentreports.cucumber.adapter.ExtentCucumberAdapter:"}
)

public class TestRunnerUI {
	
}