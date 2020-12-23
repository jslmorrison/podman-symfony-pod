<?php

namespace App\Entity;

use Ramsey\Uuid\Uuid;
use App\Repository\UserRepository;

class User
{
    private $id;
    private $name;
    private $email;

    private function __construct()
    {
    }

    public static function namedWithEmail(
        string $name,
        string $email
    ): self {
        $user = new self();
        $user->id = Uuid::uuid4()->toString();
        $user->name = $name;
        $user->email = $email;
        
        return $user;
    }

    public function id(): string
    {
        return $this->id;
    }

    public function name(): string
    {
        return $this->name;
    }

    public function email(): string
    {
        return $this->email;
    }
}
