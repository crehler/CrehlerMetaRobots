<?php declare(strict_types=1);
/**
 * @copyright 2020 Crehler Sp. z o. o. <https://crehler.com>
 *
 * @author    Jakub Medyński <jme@crehler.com>
 * @support   Crehler <support@crehler.com>
 * @created   20 mar 2020
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace Crehler\MetaRobots\Subscriber;


use Shopware\Core\System\SystemConfig\SystemConfigService;
use Shopware\Storefront\Event\StorefrontRenderEvent;
use Shopware\Storefront\Page\Page;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class StorefrontRenderSubscriber implements EventSubscriberInterface
{

    /** @var string  */
    private const DAYS_STR = ' days';

    /** @var SystemConfigService */
    private $systemConfigService;

    public function __construct(SystemConfigService $systemConfigService)
    {
        $this->systemConfigService = $systemConfigService;
    }

    public static function getSubscribedEvents(): array
    {
        return [
            StorefrontRenderEvent::class => 'onStorefrontRender'
        ];
    }

    public function onStorefrontRender(StorefrontRenderEvent $event): void
    {
        if (!array_key_exists('page', $event->getParameters())) {
            return;
        }

        /** @var Page $page */
        $page = $event->getParameters()['page'];

        if ($page === null || !method_exists($page, 'getMetaInformation') || $page->getMetaInformation() === null) {
            return;
        }

        $robotsConfig = $this->systemConfigService->get('CrehlerMetaRobots.config', $event->getSalesChannelContext()->getSalesChannel()->getId());

        $robotsConfig['revisit'] = isset($robotsConfig['revisit']) ? $robotsConfig['revisit'] . self::DAYS_STR : $page->getMetaInformation()->getRevisit();

        if(!empty($robotsConfig['customRobots'])) {
            $page->getMetaInformation()->setRobots($robotsConfig['customRobots'] ?? $page->getMetaInformation()->getRobots());
        } else {
            $page->getMetaInformation()->setRobots($robotsConfig['robots'] ?? $page->getMetaInformation()->getRobots());
        }
        if($event->getRequest()->query->has('p')){
            $page->getMetaInformation()->setRobots('noindex, follow');
        }
        $page->getMetaInformation()->setRevisit($robotsConfig['revisit']);

    }
}
