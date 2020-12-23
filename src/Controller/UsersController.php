<?php

namespace App\Controller;

use App\Repository\UserRepository;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

class UsersController extends AbstractController
{
    private $userRepository;
    
    public function __construct(UserRepository $userRepository)
    {
        $this->userRepository = $userRepository;
    }
    
    public function __invoke(): Response
    {
        $users = $this->userRepository
            ->findAll();
        return $this->render(
            'users.html.twig',
            [
                'users' => $users
            ]
        );
    }
}
