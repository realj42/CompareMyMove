<?php

namespace App\Service;

use Monolog\Logger;
use PDO;

class CompanyMatcher
{
    private $db;
    private $logger;
    private $matches = [];

    public function __construct(\PDO $db, Logger $logger)
    {
        $this->db = $db;
        $this->logger = $logger;
    }

    /**
     * @param string $propertyType - unused
     * @param string $surveyType
     * @param string $postcodePrefix
     * @param string $bedrooms
     * @return bool
     */
    public function match(
        string $propertyType,
        string $surveyType,
        string $postcodePrefix,
        string $bedrooms
    ) : bool
    {
        try {
            $query = "SELECT cmp.id,name,credits,description,email,phone,website from companies as cmp
                          INNER JOIN company_matching_settings as cms
                            on cmp.id = cms.company_id 
                      WHERE 
                          cms.postcodes LIKE :postcode
                          AND cms.bedrooms LIKE :bedrooms
                          AND cms.type = :surveyType
                          AND cmp.active  = 1 
                          AND cmp.credits > 0";
            $prepared = $this->db->prepare($query, [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION] );
            $prepared->execute([
                'postcode' => '%"' . $postcodePrefix . '"%',
                'bedrooms' => '%' . $bedrooms . '%',
                'surveyType' => $surveyType
                ]);
            $this->matches = $prepared->fetchAll(PDO::FETCH_ASSOC);
            if (count($this->matches) === 0) return false;
            return  true;

        }   catch (\PDOException $e) {
            $this->logger->error("Exception thrown {$e->getMessage()}");
            throw $e;
        }
    }

    /**
     * @throws \Exception
     */
    public function pick(int $count): void
    {
        $numMatches = count($this->matches);
        if ($numMatches <= $count) return;
        $selection = [];
        for ($ii = 0; $ii < $count; $ii++) {
            // Must ensure we choose 3 different results so remove chosen company from array
            $selector = random_int(0, $numMatches -1 - $ii);
            $selection[] = $this->matches[$selector];
            array_splice($this->matches, $selector, 1);
        }
        $this->matches = $selection;
    }

    public function results(): array
    {
        return $this->matches;
    }

    public function deductCredits() :void
    {
        try {
            $query = "UPDATE companies set credits = :credits 
                        WHERE id = :id";
            $preparedUpdate = $this->db->prepare($query, [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]);
            foreach ($this->matches as $match) {
                assert($match['credits'] > 0);
                $newCredits = $match['credits'] - 1;
                if ($newCredits <= 0) {
                    $this->logger->info("Company {$match['name']} has run out of credits");
                    $newCredits = 0;
                }
                $preparedUpdate->execute(['credits' => $newCredits, 'id' => $match['id']]);
            }

        } catch (\PDOException $e) {
            $this->logger->error("Exception thrown {$e->getMessage()}");
            throw $e;
        }
        
    }
}
