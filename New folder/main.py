from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import time

# Configure your details
LINKEDIN_EMAIL = "mayurdudhe111@gmail.com"  # Replace with your LinkedIn email
LINKEDIN_PASSWORD = "Md@16702"        # Replace with your LinkedIn password
RESUME_PATH = "/dbfs/FileStore/Mayur_D_pyspark_aws_resume.pdf"    # Replace with the path to your resume

# Initialize WebDriver
driver = webdriver.Chrome(executable_path="path_to_chromedriver")  # Update path to your WebDriver

def login_to_linkedin():
    """Logs into LinkedIn."""
    driver.get("https://www.linkedin.com/login")
    driver.find_element(By.ID, "username").send_keys(LINKEDIN_EMAIL)
    driver.find_element(By.ID, "password").send_keys(LINKEDIN_PASSWORD)
    driver.find_element(By.XPATH, "//button[@type='submit']").click()

def search_jobs():
    """Searches for Big Data fresher jobs on LinkedIn."""
    wait = WebDriverWait(driver, 10)
    search_box = wait.until(EC.presence_of_element_located((By.XPATH, "//input[@placeholder='Search']")))
    search_box.send_keys("Big Data Fresher")
    search_box.send_keys(Keys.RETURN)

    # Navigate to the Jobs tab
    jobs_tab = wait.until(EC.element_to_be_clickable((By.XPATH, "//button[contains(@data-test-modal-close-btn, 'jobs')]")))
    jobs_tab.click()

def apply_to_jobs():
    """Applies to jobs on the search results page."""
    wait = WebDriverWait(driver, 10)
    time.sleep(2)

    jobs = driver.find_elements(By.XPATH, "//a[contains(@class, 'job-card-list__title')]")
    for job in jobs:
        try:
            job.click()
            time.sleep(2)

            # Check for the Easy Apply button
            easy_apply_button = wait.until(
                EC.presence_of_element_located((By.XPATH, "//button[contains(text(), 'Easy Apply')]"))
            )
            easy_apply_button.click()

            # Upload Resume if required
            resume_upload = driver.find_element(By.XPATH, "//input[@type='file']")
            resume_upload.send_keys(RESUME_PATH)

            # Submit the application
            submit_button = driver.find_element(By.XPATH, "//button[contains(text(), 'Submit')]")
            submit_button.click()

            time.sleep(2)  # Pause before the next application
        except Exception as e:
            print(f"Skipping job due to error: {e}")
            continue

def main():
    try:
        login_to_linkedin()
        time.sleep(5)  # Wait for the homepage to load
        search_jobs()
        time.sleep(5)  # Wait for job search results to load
        apply_to_jobs()
    finally:
        driver.quit()

if __name__ == "__main__":
    main()
