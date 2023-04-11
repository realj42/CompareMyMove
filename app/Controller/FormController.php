<?php

namespace App\Controller;

use App\Service\CompanyMatcher;


class FormController extends Controller
{
    public function index()
    {
        $this->render('form.twig');
    }

    public function submit()
    {
        // Get fields passed from form
        // Ignoring fields we are not using for now
        $propertyType = $_POST['propertyType'] ?? '';
        // Hack validation !!
        $errors = false;
        if (!(in_array($propertyType, ['apartment-flat', 'house', 'bungalow']))) {
            echo "<p>Incorrect Property Type specified</p>";
            $errors = true;
        }
        $bedrooms = (int) ($_POST['bedrooms'] ?? '0');
        if ($bedrooms <= 0 || $bedrooms > 5) {
            echo "<p>Incorrect number of bedrooms specified</p>";
            $errors = true;
        }
        $surveyType = $_POST['surveyType'];
        if (!in_array($surveyType, ['homebuyer', 'building', 'valuation'])) {
            echo "<p>Incorrect Survey Type specified</p>";
            $errors = true;
        }
        $postCode = strip_tags(strtoupper($_POST['postcode'] ?? ''));
        $matches = [];
        $result = preg_match('/^[a-zA-Z]+/', $postCode, $matches );
        if (!$result || $matches[0] === '' || strlen($matches[0]) >= 3) {
            echo "<p>Incorrect post code format specified</p>";
            $errors = true;
        }
        if ($errors) {
            echo "<p>Use back key and correct errors before proceeding</p>";
            return;
        }
        $postCodePrefix = $matches[0];

        // Given normal use of form then above asserts will pass
        // For full app full validation and response supplied.

        //Find a match for the requested survey type

        $matcher = new CompanyMatcher($this->db(), $this->logger);

        if ($matcher->match($propertyType, $surveyType, $postCodePrefix, (string) $bedrooms)) {

            // got a match - pick 3 (max) results to return
            $matcher->pick(3);
            $matchedCompanies = $matcher->results();
            $this->logger->debug(
                "Search on survey: $surveyType, beds: $bedrooms, prefix: $postCodePrefix, returned " . count($matchedCompanies) . " results");
            $matcher->deductCredits();
        } else {
            $matchedCompanies = [];
        }

        $this->render('results.twig', [
            'matchedCompanies'  => $matchedCompanies,
        ]);
    }
}