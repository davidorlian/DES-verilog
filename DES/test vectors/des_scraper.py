"""
des_scraper.py
"""


from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from webdriver_manager.chrome import ChromeDriverManager

def run_des_test_vectors(message, key, num_inputs=1, driver=None):
    # Only create driver if not passed
    local_driver_created = False
    if driver is None:
        chrome_options = Options()
        chrome_options.add_argument("--headless")
        chrome_options.add_argument("--no-sandbox")
        chrome_options.add_argument("--disable-dev-shm-usage")
        driver = webdriver.Chrome(
            service=Service(ChromeDriverManager().install()),
            options=chrome_options
        )
        local_driver_created = True

    try:
        driver.get("https://people.duke.edu/~tkb13/courses/ncsu-csc405-2015fa/RESOURCES/JS-DES.shtml")

        # Fill inputs
        driver.find_element(By.NAME, "indata").clear()
        driver.find_element(By.NAME, "indata").send_keys(message)

        driver.find_element(By.NAME, "key").clear()
        driver.find_element(By.NAME, "key").send_keys(key)

        driver.find_element(By.XPATH, "//input[@value='DES Encrypt']").click()

        WebDriverWait(driver, 5).until(
            EC.text_to_be_present_in_element_value((By.ID, "details"), "Input bits:")
        )

        trace_data = driver.find_element(By.ID, "details").get_attribute("value")

        # Decide whether to quit driver
        if num_inputs == 1 and local_driver_created:
            driver.quit()
            return trace_data
        else:
            return trace_data, driver

    except Exception as e:
        print(f"[SCRAPER ERROR] {e}")
        if local_driver_created:
            driver.quit()
        raise

if __name__ == "__main__":
    # Example usage
    message = "0123456789ABCDEF"
    key = "133457799BBCDFF1"
    run_des_test_vectors(message, key, 1, None)
