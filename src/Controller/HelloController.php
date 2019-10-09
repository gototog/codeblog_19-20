<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class HelloController extends AbstractController
{

    /**
     * @Route("/hello/{number}", name="hello_number", requirements={"number"="\d+"})
     */
    public function number($number)
    {
        $names = '';
        for ($i = 0; $i < $number; $i++) {
            $names = $names . ' world';
        }

        return new Response(
            '<html><body>Hello ' . $names . '!</body></html>'
        );
    }

    /**
     * @Route("/hello/world", name="hello_world")
     */
    public function hello()
    {
        return new Response(
            '<html><body>Hello world!</body></html>'
        );
    }

    /**
     * @Route("/conditions/{name}", name="hello_name")
     */
    public function name($name)
    {
        return new Response(
            '<html><body>Hello ' . $name . '!</body></html>'
        );
    }

}
