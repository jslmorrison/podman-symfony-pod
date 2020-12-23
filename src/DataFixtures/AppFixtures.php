<?php

namespace App\DataFixtures;

use App\Entity\User;
use Doctrine\Persistence\ObjectManager;
use Doctrine\Bundle\FixturesBundle\Fixture;

class AppFixtures extends Fixture
{
    public function load(ObjectManager $manager)
    {
        $user = User::namedWithEmail('Jimmy Wong', 'jwong@example.com');
        $manager->persist($user);
        
        $user = User::namedWithEmail('Algernon Carruthers', 'acarruthers@example.com');
        $manager->persist($user);
        
        $manager->flush();
    }
}
