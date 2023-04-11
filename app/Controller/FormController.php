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
        // Brute force validation !!
        assert(in_array($propertyType, ['apartment-flat', 'house', 'bungalow']));
        $bedrooms = (int) ($_POST['bedrooms'] ?? '0');
        assert($bedrooms > 0 && $bedrooms <6);
        $surveyType = $_POST['surveyType'];
        assert(in_array($surveyType, ['homebuyer', 'building', 'valuation']));
        $postCode = strip_tags($_POST['postcode'] ?? '');
        $matches = [];
        $result = preg_match('/^[a-zA-Z]+/', $postCode, $matches );
        assert($result && $matches[0] !== '' && strlen($matches[0]) < 3);
        $postCodePrefix = $matches[0];

        // Given normal use of form then above asserts will pass
        // For full app full validation and response supplied.

        //Find a match for the requested survey type

        $matcher = new CompanyMatcher($this->db());

        if ($matcher->match($propertyType, $surveyType, $postCodePrefix, (string) $bedrooms)) {
            // got a match - pick 3 (max) results to return
            $matcher->pick(3);
            $matchedCompanies = $matcher->results();
            $matcher->deductCredits();
        } else {
            $matchedCompanies = [];
        }

        $this->render('results.twig', [
            'matchedCompanies'  => $matchedCompanies,
        ]);
    }
}